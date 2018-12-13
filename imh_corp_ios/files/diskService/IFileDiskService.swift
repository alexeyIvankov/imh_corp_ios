//
//  IFileDiskService.swift
//  LemoLink
//
//  Created by Alexey Ivankov on 14.03.2018.
//  Copyright © 2018 Business Technology. All rights reserved.
//

import Foundation

public protocol IFileDiskService {
    
    func createIfNeedWorkDirectory(accountId:String) -> String
    
    func createIfNeedNewsDirectory(accountId:String,
                                   newsId:String) -> String
    
    func createIfNeedNewsAttachDirectory(accountId:String,
                                         newsId:String,
                                         fileId:String) -> String
    
    func createIfNeedDataBaseDirectory() -> String
    
    
    func documentDirectory() -> String
    func libaryDirectory() -> String
    func cashDirectory() -> String
    func tempDirectory() -> String
    
    func createDirectory(path:String)
    func createDirectoryIfNeed(path:String)
    
    func removeFile(path:String)
    func copyFile(srcPath:String, toPath:String)
    func saveFile(path:String, data: NSData) -> Bool
    func readFile(path: String) -> Data?
    func fileExists(path:String) -> Bool
}


