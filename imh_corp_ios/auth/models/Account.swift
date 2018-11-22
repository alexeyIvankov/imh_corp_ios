//
//  Account.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class Account :  Object, IAccount{
    
    @objc dynamic var name:String? = nil
    @objc dynamic var position:String? = nil
    @objc dynamic var phone:String? = nil
    
    @objc dynamic var auth:Auth!
    var news = List<News>()
    
    func getAuth() -> IAuth{
        return self.auth
    }
    
    func getNews()->[INews]{
        return self.news.toArray()
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
