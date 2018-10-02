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
    }
    
    class func load(type:TypeSB) -> UIStoryboard{
        
        if type == .auth{
            return UIStoryboard(name:TypeSB.auth.rawValue, bundle:nil)
        }
        else  if type == .root{
            return UIStoryboard(name:TypeSB.root.rawValue, bundle:nil)
        }
        
        fatalError("storyboard not finded")
    }
}
