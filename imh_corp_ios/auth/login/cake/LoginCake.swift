//
//  LoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class LoginCake : ILoginCake {
    
    var router: ILoginRouter
    var service: ILoginServiceLayer
    var design:ILoginDesign
    
    required init(router:ILoginRouter,
                  service:ILoginServiceLayer,
                  design:ILoginDesign){
        
        self.router = router
        self.service = service
        self.design = design
    }
}
