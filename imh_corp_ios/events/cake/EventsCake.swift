//
//  LoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class EventsCake : IEventsCake {
    
    var router: IEventsRouter
    var director: IEventsDirector
    var design:IEventsDesign
    
    required init(router:IEventsRouter,
                  director:IEventsDirector,
                  design:IEventsDesign){
        
        self.router = router
        self.director = director
        self.design = design
    }
}
