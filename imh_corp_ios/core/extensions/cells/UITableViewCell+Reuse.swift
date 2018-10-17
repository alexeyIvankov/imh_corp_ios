//
//  UITableViewCell+Reuse.swift
//  Neon
//
//  Created by Alexey Ivankov on 31.05.2018.
//  Copyright © 2018 Norvik Bank. All rights reserved.
//

import Foundation
import Foundation
import UIKit

extension UITableViewCell {
    
    public class func reuseIdCell() -> String {
        return String(describing: self)
    }
    
    public class func nibCell() -> UINib{
        return UINib(nibName:String(describing: self), bundle: nil)
    }
}
