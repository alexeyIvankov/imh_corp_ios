//
//  RootServiceLayer.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 23.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class RootDirector : IRootDirector {
   
    let securityService:ISecurityService
    let authCake:IAuthCake
    
    required init(securityService:ISecurityService,
                  authCake:IAuthCake){
        self.securityService = securityService
        self.authCake = authCake
    }
}
