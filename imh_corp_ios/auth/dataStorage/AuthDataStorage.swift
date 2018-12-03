//
//  AuthDataStorage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 22/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class AuthDataStorage : IAuthDataStorage{
  
    private let db:IDataBase
    
    required init(db:IDataBase) {
        self.db = db
    }
    
    func trySaveAuthorization(account:[String:Any]) {
       
        if let name:String = account["name"] as? String,
            let phone:String = account["phone"] as? String,
            let accessToken:String = (account["tokens"] as? [String:Any])?["access"] as? String,
            let refreshToken:String = (account["tokens"] as? [String:Any])?["refresh"] as? String{
            
            let auth:AuthRealm = AuthRealm()
            auth.accessToken = accessToken
            auth.refreshToken = refreshToken
            
            let account:AccountRealm = AccountRealm()
            account.name = name
            account.phone = phone
            account.id = phone
            account.auth = auth
            
            let session:SessionRealm = SessionRealm()
            session.dateCreated = String(NSDate().timeIntervalSince1970)
            session.lastUpdate = String(NSDate().timeIntervalSince1970)
            session.account = account
            
            let settings:SettingsRealm = SettingsRealm()
            settings.account = account
            account.settings = settings
            
            self.db.synchWrite(obj: [auth, account, session])
        }
        
    }
}
