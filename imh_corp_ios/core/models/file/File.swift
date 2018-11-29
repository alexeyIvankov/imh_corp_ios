//
//  File.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class File : Object, IFile{
   
    @objc dynamic var fileId: String! = nil
    @objc dynamic var name: String? = nil
    @objc dynamic var type: String! = nil
    @objc dynamic var contentType: String! = nil
    @objc dynamic var dateCreated: String? = nil
    @objc dynamic var downloadUrl: String! = nil
    @objc dynamic var largeIconUrl: String? = nil
    @objc dynamic var previewUrl: String? = nil
    @objc dynamic var smalIconUrl: String? = nil
    @objc dynamic var size: String? = nil
    @objc dynamic var url: String? = nil
    @objc dynamic var webUrl: String? = nil
    @objc dynamic var localPath: String? = nil
    
    func update(json: [String : Any]) {
        
        let fileId =  json["id"] as? Int
        let name =  json["name"] as? String
        let size = json["size"] as? Int
        let type = json["type"] as? String
        let contentType =  json["content_type"] as? String
        let dateCreated =  json["date_created"] as? String
        let downloadUrl =  json["download_url"] as? String
        let largeIconUrl =  json["large_icon_ur"] as? String
        let previewUrl =  json["preview_ur"] as? String
        let smallIconUrl =  json["small_icon_ur"] as? String
        let url =  json["url"] as? String
        let webUrl = json["web_url"] as? String

        
        if fileId != nil{
            self.fileId = String(fileId!)
        }
        
        if type != nil{
            self.type = type
        }
        
        if contentType != nil{
            self.contentType = contentType
        }
        
        if downloadUrl != nil{
            self.downloadUrl = downloadUrl
        }
        
        if size != nil{
            self.size = String(size!)
        }
        
        self.name = name
        self.dateCreated = dateCreated
        self.largeIconUrl = largeIconUrl
        self.previewUrl = previewUrl
        self.smalIconUrl = smallIconUrl
        self.url = url
        self.webUrl = webUrl
    }
    
    
}
