//
//  FileDirector.swift
//  
//
//  Created by Alexey Ivankov on 11/12/2018.
//

import Foundation

class FileDirector : IFileDirector {
    
    private let sessionService:ISessionService
    private let diskService:IFileDiskService
    private let network:INetwork
    private let dataStorage:IFileDataStorage
    
    required init(sessionService:ISessionService,
                  diskService:IFileDiskService,
                  network:INetwork,
                  dataStorage:IFileDataStorage){
        self.sessionService = sessionService
        self.diskService = diskService
        self.network = network
        self.dataStorage = dataStorage
    }
    
    func giveMeFile(operationId:String,
                    typeFile:TypeFileRequest,
                    success: @escaping (Data, String)->(),
                    failed:@escaping  (NSError, String)->(),
                    startLoad:(()->())?,
                    endLoad:(()->())?,
                    progressLoad:((Float)->())?) {
        
        self.sessionService.activeSession { (session) in
            
            if session == nil{
                return failed(generateError(message: "not authorized"), operationId)
            }
            
            let accountId:String = session!.getAccount().id
            let accessToken:String = session!.getAccount().getAuth().accessToken!
            
            switch typeFile{
           
            case .newsAttach(let newsId, let fileId): do {
                
                }
                
            case .newsPreview(let newsId, let fileId): do {
                    let path = self.generatePath(typeFile: typeFile, accountId: accountId)
                    let fileData = self.getFile(path: path)
                
                    if fileData != nil{
                        success(fileData!, operationId)
                    }
                    else {
                
                        self.dataStorage.getNewsAttach(accountId: accountId, newsId: newsId, fileId: fileId, completion: { (file) in
                            
                            guard file != nil else {
                                return failed(generateError(message: "file not found"), operationId)
                            }
                            
                            guard file!.previewUrl != nil else {
                                return failed(generateError(message: "file preview url not found"), operationId)
                            }
                            
                            DispatchQueue.main.async {
                                 startLoad?()
                            }
                            
                            self.network.apiDirector.socialNetworkModule.image(accessToken: accessToken, networkType: "yammer", imageUrl: file!.previewUrl!, width: 200, height: 200, success: { (data) in
                                
                                DispatchQueue.global().async {
                                    let _ = self.diskService.saveFile(path: path, data: data as NSData)
                                    
                                    DispatchQueue.main.async {
                                        endLoad?()
                                        success(data, operationId)
                                    }
                                }
                                
                            }, failed: { (error) in
                                
                                DispatchQueue.main.async {
                                    endLoad?()
                                    failed(error, operationId)
                                }
                            })
                        })
                    }
                }
            }
        }
    }
    
    private func generatePath(typeFile:TypeFileRequest,
                              accountId:String) -> String{
        
        var path:String!
        
        switch typeFile {
    
        case .newsAttach(let newsId, let fileId):do {
                path = self.diskService.createIfNeedNewsAttachDirectory(accountId: accountId, newsId: newsId, fileId: fileId) + fileId + "_attach"
            }
            
        case .newsPreview(let newsId, let fileId):do {
                path = self.diskService.createIfNeedNewsAttachDirectory(accountId: accountId, newsId: newsId, fileId: fileId) + fileId + "_preview"
            }
        }
        
        return path
    }
    
    private func getFile(path:String) -> Data?{
        guard self.diskService.fileExists(path: path) == true else {
            return nil
        }
        return self.diskService.readFile(path: path)
    }
}
