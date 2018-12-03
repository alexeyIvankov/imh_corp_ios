//
//  Session.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 22/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class SessionRealm : Object, ISession{
    
    @objc dynamic var name:String? = nil
    @objc dynamic var dateCreated:String? = nil
    @objc dynamic var lastUpdate:String? = nil
    
    @objc dynamic var account:AccountRealm!
    
    func getAccount() -> IAccount{
        return self.account
    }
    
    override static func primaryKey() -> String? {
        return "dateCreated"
    }
}
