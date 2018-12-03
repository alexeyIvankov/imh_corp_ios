//
//  SessionService.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.09.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class SessionService : ISessionService{
    
    private var dataBase:IDataBase
    
    required init(dataBase:IDataBase) {
        self.dataBase = dataBase
    }
    
    func getActiveSession() -> ISession?{
        let sesion:SessionRealm? = self.dataBase.synchFetch(options: nil).first
        
        if sesion == nil{
            return nil
        }
        
        return Session.createSession(session: sesion!)
    }
    func activeSession(completion: @escaping(ISession?)->()){
        self.dataBase.asynchFetch(type: SessionRealm.self, options: nil) { (sessions, ctx)  in
            
            if sessions.count == 0{
                completion(nil)
            }
            else {
                 completion(Session.createSession(session: sessions.first!))
            }
           
        }
    }
}
