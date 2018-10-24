//
//  ILoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol INewsCake : AnyObject {
    
    var router:INewsRouter { get }
    var director:INewsDirector { get }
    var design:INewsDesign { get }
}
