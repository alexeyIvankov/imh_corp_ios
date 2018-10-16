//
//  WelcomeCake.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class WelcomeCake : IWelcomeCake {
    
    var router:IWelcomeRouter
    var director:IWelcomeDirector
    var design:IWelcomeDesign
    
    required init(router:IWelcomeRouter,
                  director:IWelcomeDirector,
                  design:IWelcomeDesign) {
        
        self.router = router
        self.director = director
        self.design = design
    }
}
