//
//  UIStoryboard+Type.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard{
    
    public enum TypeSB: String{
        case auth = "AuthSB"
        case root = "Main"
        case welcome = "WelcomeSB"
        case news = "NewsSB"
        case employeeRequests = "EmployeeRequestsSB"
        case events = "EventsSB"
        case more = "MoreSB"
    }
    
    class func load(type:TypeSB) -> UIStoryboard{
        return UIStoryboard(name:type.rawValue, bundle:nil)
    }
}
