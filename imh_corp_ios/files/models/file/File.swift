//
//  File.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 30/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class File : IFile {
    
    var fileId: String!
    var newsId:String!
    var name: String?
    var type: String!
    var contentType: String!
    var dateCreated: String?
    var largeIconUrl: String?
    var previewUrl: String?
    var smalIconUrl: String?
    var size: String?
    var url: String?
    var localPath: String?
    var contentClass: String?
    
    static func createFiles(files:[IFile])-> [IFile]{
        var container = [IFile]()
        
        for item in files{
            container.append(File(file: item))
        }
        return container
    }
    
    required init(file:IFile){
        self.fileId = file.fileId
        self.newsId = file.newsId
        self.name = file.name
        self.type = file.type
        self.contentType = file.contentType
        self.dateCreated = file.dateCreated
        self.largeIconUrl = file.largeIconUrl
        self.previewUrl = file.previewUrl
        self.smalIconUrl = file.smalIconUrl
        self.size = file.size
        self.url = file.url
        self.localPath = file.localPath
        self.contentClass = file.contentClass
    }
}
