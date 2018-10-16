//
//  LoginDirector.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class LoginDirector : ILoginDirector {
    
    var authSerice:IAuthDirector
    var securityService:ISecurityService
    
    required init(authSerice:IAuthDirector, securityService:ISecurityService){
        self.authSerice = authSerice
        self.securityService = securityService
    }
  
}
