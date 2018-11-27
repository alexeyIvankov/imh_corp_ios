//
//  RootCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 27.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class RootCake : IRootCake {
    
    var router: IRootRouter
    var director:IRootDirector
    var design:IRootDesign
    
    required init(router:IRootRouter,
                  serviceLayer:IRootDirector,
                  design:IRootDesign) {
        self.router = router
        self.director = serviceLayer
        self.design = design
    }
}
