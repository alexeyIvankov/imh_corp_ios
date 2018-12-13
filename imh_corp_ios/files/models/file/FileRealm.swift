//
//  File.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class FileRealm : Object, IFile{
    
    @objc dynamic var accountId: String! = nil
    @objc dynamic var fileId: String! = nil
    @objc dynamic var newsId: String! = nil
    @objc dynamic var name: String? = nil
    @objc dynamic var type: String! = nil
    @objc dynamic var contentType: String! = nil
    @objc dynamic var dateCreated: String? = nil
    @objc dynamic var url: String? = nil
    @objc dynamic var largeIconUrl: String? = nil
    @objc dynamic var previewUrl: String? = nil
    @objc dynamic var smalIconUrl: String? = nil
    @objc dynamic var contentClass: String? = nil
    @objc dynamic var size: String? = nil
    @objc dynamic var localPath: String? = nil
    
    override static func primaryKey() -> String? {
        return "fileId"
    }
}
