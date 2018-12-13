//
//  FileDiskService.swift
//  LemoLink
//
//  Created by Alexey Ivankov on 14.03.2018.
//  Copyright © 2018 Business Technology. All rights reserved.
//

import Foundation

class FileDiskService : IFileDiskService {
    
    private let fileManager:FileManager
    
    private let nameWorkingFolder:String
    
    private let nameDataBaseFolder:String = "db"
    private let nameFilesFolder:String = "files"
    private let nameNewsFolder:String = "news"
    
    
    required init(nameWorkingFolder:String) {
        
        self.fileManager = FileManager()
        self.nameWorkingFolder = nameWorkingFolder
    }
    
    private func createIfNeedWorkDirectory() -> String {
        
        let path:String = self.cashDirectory() +  "/".appendingFormat(nameWorkingFolder)
        createDirectoryIfNeed(path: path)
        return path
    }
    
    func createIfNeedWorkDirectory(accountId:String) -> String{
        let path:String = self.createIfNeedWorkDirectory() + "/".appendingFormat(accountId)
        createDirectoryIfNeed(path: path)
        return path
    }
    
    func createIfNeedNewsDirectory(accountId:String, newsId:String) -> String{
        let path = self.createIfNeedWorkDirectory(accountId: accountId)
            +  "/".appendingFormat(self.nameNewsFolder)
            +  "/".appendingFormat(newsId)
       
        createDirectoryIfNeed(path: path)
        return path
    }
    
    func createIfNeedNewsAttachDirectory(accountId:String,
                                               newsId:String,
                                               fileId:String) -> String{
        let path = self.createIfNeedNewsDirectory(accountId: accountId, newsId: newsId)
            +  "/".appendingFormat(self.nameFilesFolder)
            +  "/".appendingFormat(fileId)
        
        createDirectoryIfNeed(path: path)
        return path
    }
    
    func createIfNeedNewsDirectory() -> String{
        let path:String = self.createIfNeedWorkDirectory() +  "/".appendingFormat(nameNewsFolder)
        createDirectoryIfNeed(path: path)
        return path
    }
    
    
    func createIfNeedDataBaseDirectory() -> String {
        let path:String = self.createIfNeedWorkDirectory() +  "/".appendingFormat(nameDataBaseFolder)
        createDirectoryIfNeed(path: path)
        return path
    }
    

    func documentDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
    }
    
    func libaryDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
    }
    
    func cashDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
    }
    
    func tempDirectory() -> String{
        return NSTemporaryDirectory()
    }

    func fileExists(path:String) -> Bool {
        return self.fileManager.fileExists(atPath: path)
    }
    
    func createDirectory(path:String) {
       try! self.fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
    }
    
    func removeFile(path:String) {
         try! self.fileManager.removeItem(atPath: path)
    }
    
    func copyFile(srcPath:String, toPath:String) {
        try! self.fileManager.copyItem(atPath: srcPath, toPath: toPath);
    }
    
    func saveFile(path:String, data: NSData) -> Bool {
        let fileCreated:Bool = self.fileManager.createFile(atPath: path, contents: data as Data, attributes: nil)
        return fileCreated
    }
    
    func readFile(path: String) -> Data? {
        return self.fileManager.contents(atPath: path)
    }
    
    public func createDirectoryIfNeed(path:String) {
        
        if fileExists(path: path) == false {
            self.createDirectory(path: path)
        }
    }

}
