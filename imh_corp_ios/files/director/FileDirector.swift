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
    private var queueDownloadOperation:OperationQueue
    
    required init(sessionService:ISessionService,
                  diskService:IFileDiskService,
                  network:INetwork,
                  dataStorage:IFileDataStorage){
        
        self.sessionService = sessionService
        self.diskService = diskService
        self.network = network
        self.dataStorage = dataStorage
        
        self.queueDownloadOperation = OperationQueue()
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
                        
                        guard file!.url != nil else {
                            return failed(generateError(message: "file url not found"), operationId)
                        }
                        
                        DispatchQueue.main.async {
                            startLoad?()
                        }
                        
                       
                         self.network.apiDirector.socialNetworkModule.attach(accessToken: accessToken, networkType: "yammer", attachUrl: file!.url!, success: { (data) in
                            
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
                
                
                
            case .newsPreview(let newsId, let fileId): do {
                
                DispatchQueue.global().async {
                  

                    let path = self.generatePath(typeFile: typeFile, accountId: accountId)
                    let fileData = self.getFile(path: path)
                    
                    if fileData != nil{
                        DispatchQueue.main.async {
                            success(fileData!, operationId)
                        }
                    }
                    else {
                        
                        self.addLoadAndSavePreviewOperationIfNeed(operation: OperationDownloadAndSavePreview(accountId: accountId,
                                                                                                             newsId: newsId,
                                                                                                             fileId: fileId,
                                                                                                             operationId: operationId,
                                                                                                             accessToken: accessToken,
                                                                                                             path: path,
                                                                                                             sessionService:self.sessionService,
                                                                                                             diskService: self.diskService,
                                                                                                             network: self.network,
                                                                                                             dataStorage: self.dataStorage,
                                                                                                             success: { (data, operationId) in
                                                                                                                success(data, operationId)
                        }, failed: { (error, operationId) in
                            failed(error, operationId)
                        }, startLoad: {
                            startLoad?()
                        }, endLoad: {
                            endLoad?()
                        }, progressLoad: { (progress) in
                            progressLoad?(progress)
                        }))
        
                    }
                }
                }
            }
        }
    }
    
    private func addLoadAndSavePreviewOperationIfNeed(operation:OperationDownloadAndSavePreview){
        
        let operations = self.queueDownloadOperation.operations as! [OperationDownloadAndSavePreview]
        
        for item in operations{
            
            if item.fileId == operation.fileId{
                return
            }
        }
        self.queueDownloadOperation.addOperation(operation)
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

class CallBacksStorage
{
    private var storageCallbacks:NSMapTable<NSString, AnyObject>
    private var saveQueue:DispatchQueue
    
    required init(){
        self.storageCallbacks = NSMapTable(keyOptions: NSPointerFunctions.Options.copyIn,
                                           valueOptions: NSPointerFunctions.Options.strongMemory)
        self.saveQueue = DispatchQueue(label: "CallBacksStorage.saveQueue")
    }
    
    public func save(id:String, callback:AnyObject){
        self.saveQueue.async {
            self.storageCallbacks.setObject(callback, forKey: NSString(string: id))
        }
    }
    
    public func get(id:String) -> AnyObject?{
        
        var callback:AnyObject? = nil
        
        self.saveQueue.sync {
            callback = self.storageCallbacks.object(forKey: NSString(string: id))
        }
        
        return callback
    }
}

class OperationDownloadAndSavePreview:Operation{
    
    private let sessionService:ISessionService
    private let diskService:IFileDiskService
    private let network:INetwork
    private let dataStorage:IFileDataStorage
    public  let accountId:String
    public  let newsId:String
    public  let fileId:String
    public  let operationId:String
    private let accessToken:String
    private let path:String
    
    private let success:(Data, String)->()
    private let failed: (NSError, String)->()
    private let startLoad:(()->())?
    private let endLoad:(()->())?
    private let progressLoad:((Float)->())?
    
    required init(accountId:String,
                  newsId:String,
                  fileId:String,
                  operationId:String,
                  accessToken:String,
                  path:String,
                  sessionService:ISessionService,
                  diskService:IFileDiskService,
                  network:INetwork,
                  dataStorage:IFileDataStorage,
                  success: @escaping (Data, String)->(),
                  failed:@escaping  (NSError, String)->(),
                  startLoad:(()->())?,
                  endLoad:(()->())?,
                  progressLoad:((Float)->())?){
        
        self.accountId = accountId
        self.newsId = newsId
        self.fileId = fileId
        self.operationId = operationId
        self.accessToken = accessToken
        self.path = path
        
        self.success = success
        self.failed = failed
        self.startLoad = startLoad
        self.endLoad = endLoad
        self.progressLoad = progressLoad
        
        self.sessionService = sessionService
        self.diskService = diskService
        self.network = network
        self.dataStorage = dataStorage
    }
    
    override func main() {
        
        let group = DispatchGroup()
        group.enter()
        
        self.dataStorage.getNewsAttach(accountId: self.accountId, newsId: self.newsId, fileId: self.fileId, completion: { (file) in
            
            guard file != nil else {
                group.leave()
                return self.failed(generateError(message: "file not found"), self.operationId)
            }
            
            guard file!.previewUrl != nil else {
                group.leave()
                return self.failed(generateError(message: "file preview url not found"), self.operationId)
            }
            
            DispatchQueue.main.async {
                self.startLoad?()
            }
            
            self.network.apiDirector.socialNetworkModule.image(accessToken: self.accessToken, networkType: "yammer", imageUrl: file!.previewUrl!, width: 200, height: 200, success: { (data) in
                
                DispatchQueue.global().async {
                    let _ = self.diskService.saveFile(path: self.path, data: data as NSData)
                    
                    DispatchQueue.main.async {
                        self.endLoad?()
                        self.success(data, self.operationId)
                        group.leave()
                    }
                }
                
            }, failed: { (error) in
                
                DispatchQueue.main.async {
                    self.endLoad?()
                    self.failed(error, self.operationId)
                    group.leave()
                }
            })
        })
        
        group.wait()
    }
}
