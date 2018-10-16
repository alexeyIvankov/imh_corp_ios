//
//  AuthCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 27.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class AuthCake : IAuthCake{
    
    var authDirector: IAuthDirector
    var authRouter: IAuthRouter
    
    required init(authDirector: IAuthDirector,
                  authRouter: IAuthRouter){
        
        self.authDirector = authDirector
        self.authRouter = authRouter
    }
}
