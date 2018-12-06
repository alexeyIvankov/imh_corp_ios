//
//  Account.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 03/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class Account : IAccount{
    var name: String!
    var position: String?
    var id: String!
    var phone: String!
    
    var auth:IAuth!
    var settings:ISettings!
    
    static func createAccount(account:IAccount) -> IAccount{
        
        let newAccount = Account(account: account)
        newAccount.auth = Auth(auth: account.getAuth())
        newAccount.settings = Settings(settings: account.getSettings())
        
        return newAccount
    }
    
    required init(account:IAccount){
        self.name = account.name
        self.position = account.position
        self.id = account.id
        self.phone = account.phone
    }
    
    func getAuth() -> IAuth {
        return self.auth
    }
    
    func getSettings() -> ISettings {
        return self.settings
    }
}
