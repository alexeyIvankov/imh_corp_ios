//
//  ILoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IEventsCake : AnyObject {
    
    var router:IEventsRouter { get }
    var director:IEventsDirector { get }
    var design:IEventsDesign { get }
}
