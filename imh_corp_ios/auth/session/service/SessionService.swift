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
        let sesion:Session? = self.dataBase.synchFetch(options: nil).first
        return sesion
    }
    func activeSession(completion: @escaping(ISession?)->()){
        self.dataBase.asynchFetch(type: Session.self, options: nil) { (sessions, ctx)  in
            completion(sessions.first)
        }
    }
}
