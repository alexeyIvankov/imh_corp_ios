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
    var groups = List<NewsGroup>()
    
    func getAuth() -> IAuth{
        return self.auth
    }
    
    func getGroupsNews()->[INewsGroup]{
        return self.groups.toArray()
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
