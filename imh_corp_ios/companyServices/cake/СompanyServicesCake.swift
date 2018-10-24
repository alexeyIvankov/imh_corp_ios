//
//  LoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class СompanyServicesCake : IСompanyServicesCake {
    
    var router: IСompanyServicesRouter
    var director: IСompanyServicesDirector
    var design:IСompanyServicesDesign
    
    required init(router:IСompanyServicesRouter,
                  director:IСompanyServicesDirector,
                  design:IСompanyServicesDesign){
        
        self.router = router
        self.director = director
        self.design = design
    }
}
