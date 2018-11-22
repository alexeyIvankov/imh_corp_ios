//
//  SessionService.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.09.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class SessionService : ISessionService{
   
    var activeSession: ISession? {
        return getSession()
    }
    
    private var dataBase:IDataBase
    
    required init(dataBase:IDataBase) {
        self.dataBase = dataBase
    }
    
    private func getSession() -> ISession?{
        let sesion:Session? = self.dataBase.synchFetch(options: nil).first
        return sesion
    }
}
