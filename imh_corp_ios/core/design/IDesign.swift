//
//  IDesign.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 27.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

protocol IDesign {
    
    init(appDesign:IAppDesign)
    func apply<T:UIViewController>(vc:T)
}
