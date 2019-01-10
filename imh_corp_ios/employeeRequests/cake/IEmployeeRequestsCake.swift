//
//  ILoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IEmployeeRequestsCake : AnyObject {
    
    var router:IEmployeeRequestsRouter { get }
    var director:IEmployeeRequestsDirector { get }
    var design:IEmployeeRequestsDesign { get }
}
