//
//  ILoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol ILoginCake : AnyObject {
    
    var router:ILoginRouter { get }
    var director:ILoginDirector { get }
    var design:ILoginDesign { get }
}
