//
//  ILoginCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IConfirmationCake : AnyObject {
    
    var router:IConfirmationRouter { get }
    var director:IConfirmationDirector { get }
    var design:IConfirmationDesign { get }
}
