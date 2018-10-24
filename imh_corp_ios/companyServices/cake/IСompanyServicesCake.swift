//
//  ILoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IСompanyServicesCake : AnyObject {
    
    var router:IСompanyServicesRouter { get }
    var director:IСompanyServicesDirector { get }
    var design:IСompanyServicesDesign { get }
}
