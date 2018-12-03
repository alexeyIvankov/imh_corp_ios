//
//  AccountRealm.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class AccountRealm :  Object, IAccount{
    
    @objc dynamic var name:String! = nil
    @objc dynamic var position:String? = nil
    @objc dynamic var phone:String! = nil
    @objc dynamic var id:String! = nil
   
    @objc dynamic var auth:AuthRealm!
    @objc dynamic var settings:SettingsRealm!
    
    var groups = List<NewsGroupRealm>()
    
    func getAuth() -> IAuth{
        return self.auth
    }
    
    func getSettings() -> ISettings{
        return self.settings
    }
    
    func getGroupsNews()->[INewsGroup]{
        return self.groups.convertToArray()
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
