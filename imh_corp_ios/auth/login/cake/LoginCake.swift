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
    var director: ILoginDirector
    var design:ILoginDesign
    
    required init(router:ILoginRouter,
                  director:ILoginDirector,
                  design:ILoginDesign){
        
        self.router = router
        self.director = director
        self.design = design
    }
}
