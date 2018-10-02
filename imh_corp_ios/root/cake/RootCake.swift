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
    var serviceLayer:IRootServiceLayer
    
    required init(router:IRootRouter, serviceLayer:IRootServiceLayer) {
        self.router = router
        self.serviceLayer = serviceLayer
    }
}
