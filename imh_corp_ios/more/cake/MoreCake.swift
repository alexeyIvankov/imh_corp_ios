//
//  LoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class MoreCake : IMoreCake {
    
    var router: IMoreRouter
    var director: IMoreDirector
    var design:IMoreDesign
    
    required init(router:IMoreRouter,
                  director:IMoreDirector,
                  design:IMoreDesign){
        
        self.router = router
        self.director = director
        self.design = design
    }
}
