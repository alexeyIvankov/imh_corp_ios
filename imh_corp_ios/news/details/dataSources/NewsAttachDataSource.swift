//
//  NewsAttachDataSource.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 18/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class NewsAttachDataSource : InputSource {
   
    
    let file:IFile
    let newsId:String
    let fileDirector:IFileDirector
    
    required init(file:IFile,
                  newsId:String,
                  fileDirector:IFileDirector){
        self.file = file
        self.newsId = newsId
        self.fileDirector = fileDirector
    }
    
    func loadPreview(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        
        DispatchQueue.global().async {
            
            self.fileDirector.giveMeFile(operationId: self.newsId,
                                         typeFile: TypeFileRequest.newsPreview(newsId: self.newsId, fileId: self.file.fileId),
                                         success: { (data, operationId) in
                                            
                                            guard  self.newsId == operationId else {
                                                return
                                            }
                                            
                                            let image = UIImage(data: data)
                                            
                                            DispatchQueue.main.async(execute: {
                                                
                                                if image != imageView.image{
                                                    imageView.image = image
                                                }
                                                callback(image)
                                            })
                                            
            }, failed: { (error, operationId) in
                
            }, startLoad: nil, endLoad: nil, progressLoad: nil)
        }
    }
    
    func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        
        DispatchQueue.global().async {
            
            self.fileDirector.giveMeFile(operationId: self.newsId,
                                         typeFile: TypeFileRequest.newsAttach(newsId: self.newsId, fileId:self.file.fileId),
                                         success: { (data, operationId) in
                                            
                                            guard  self.newsId == operationId else {
                                                return
                                            }
                                            
                                            let image = UIImage(data: data)
                                            
                                            DispatchQueue.main.async(execute: {
                                                
                                                if image != imageView.image{
                                                    imageView.image = image
                                                }
                                                callback(image)
                                            })
                                            
            }, failed: { (error, operationId) in
                
            }, startLoad: nil, endLoad: nil, progressLoad: nil)
        }
    }
}
