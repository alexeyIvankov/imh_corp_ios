//
//  IWelcomeCake.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import UIKit

protocol IWelcomeCake : AnyObject {
    
    var router:IWelcomeRouter { get }
    var director:IWelcomeDirector { get }
    var design:IWelcomeDesign { get }
}
