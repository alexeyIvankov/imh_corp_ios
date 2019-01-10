//
//  LoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class EmployeeRequestsCake : IEmployeeRequestsCake {
    
    var router: IEmployeeRequestsRouter
    var director: IEmployeeRequestsDirector
    var design:IEmployeeRequestsDesign
    
    required init(router:IEmployeeRequestsRouter,
                  director:IEmployeeRequestsDirector,
                  design:IEmployeeRequestsDesign){
        
        self.router = router
        self.director = director
        self.design = design
    }
}
