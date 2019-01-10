//
//  LoginDesign.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 27.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class EmployeeRequestsDesign : IEmployeeRequestsDesign {
    
    required init(appDesign: IAppDesign) {
        
    }
    
    func apply<T>(vc: T) where T : UIViewController {
        
        guard let controller = vc as? EmployeeRequestsController else {
            return
        }
    }
    
}
