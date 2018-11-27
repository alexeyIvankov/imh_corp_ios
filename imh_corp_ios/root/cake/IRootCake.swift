//
//  IRootCake.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 27.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

protocol IRootCake : AnyObject {
    
    var router:IRootRouter { get }
    var director:IRootDirector { get }
    var design:IRootDesign { get }
}
