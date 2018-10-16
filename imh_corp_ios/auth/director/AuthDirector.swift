//
//  AuthServices.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 22.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class AuthDirector : IAuthDirector {

    private let saveAuthKey = "auth"
    
    var securityService:ISecurityService
    var sessionService:ISessionService
    var network:INetwork
    
    required init( network:INetwork,
                   securityService:ISecurityService,
                   sessionService:ISessionService){
        
        self.network = network
        self.securityService = securityService
        self.sessionService = sessionService
    }
    
    func isAuth() -> Bool{
        return false
    }    
}
