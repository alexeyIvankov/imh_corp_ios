//
//  News.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class NewsRealm: Object, INews {
    
    @objc dynamic var newsId:String! = nil
    @objc dynamic var accountId:String! = nil
    @objc dynamic var groupId:String! = nil
    @objc dynamic var groupName:String! = nil
    @objc dynamic var body:String! = nil
    @objc dynamic var dateCreated:Int = 0
    
    override static func primaryKey() -> String? {
        return "dateCreated"
    }
}
