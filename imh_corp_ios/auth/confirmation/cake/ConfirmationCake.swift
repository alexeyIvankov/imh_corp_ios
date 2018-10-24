//
//  LoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class ConfirmationCake : IConfirmationCake {
    
    var router: IConfirmationRouter
    var director: IConfirmationDirector
    var design:IConfirmationDesign
    
    required init(router:IConfirmationRouter,
                  director:IConfirmationDirector,
                  design:IConfirmationDesign){
        
        self.router = router
        self.director = director
        self.design = design
    }
}
