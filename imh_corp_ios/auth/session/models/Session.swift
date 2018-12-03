//
//  Session.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 03/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class Session : ISession{
    
    var name: String?
    var dateCreated: String?
    var lastUpdate: String?
    var account:IAccount!
    
    static func createSession(session:ISession) -> ISession{
        let newSession = Session(session: session)
        newSession.account = Account.createAccount(account: session.getAccount())
        return session
    }
    
    required init(session:ISession) {
        self.name = session.name
        self.dateCreated = session.dateCreated
        self.lastUpdate = session.lastUpdate
    }
    
    func getAccount() -> IAccount {
        return self.account
    }
}
