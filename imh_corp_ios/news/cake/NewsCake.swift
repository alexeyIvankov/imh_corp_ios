//
//  LoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class NewsCake : INewsCake {
    
    var router: INewsRouter
    var director: INewsDirector
    var design:INewsDesign
    
    required init(router:INewsRouter,
                  director:INewsDirector,
                  design:INewsDesign){
        
        self.router = router
        self.director = director
        self.design = design
    }
}
