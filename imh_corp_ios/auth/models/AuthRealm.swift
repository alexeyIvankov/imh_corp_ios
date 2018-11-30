//
//  Auth.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class AuthRealm: Object, IAuth{
    @objc dynamic var accessToken:String? = nil
    @objc dynamic var refreshToken:String? = nil
    
    override static func primaryKey() -> String? {
        return "accessToken"
    }
}
