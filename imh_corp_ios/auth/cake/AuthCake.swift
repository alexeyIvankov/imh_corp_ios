//
//  AuthCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 27.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class AuthCake : IAuthCake{
    
    var authService: IAuthService
    var authRouter: IAuthRouter
    
    required init(authService: IAuthService,
                  authRouter: IAuthRouter){
        
        self.authService = authService
        self.authRouter = authRouter
    }
}
