//
//  UICollectionViewCell+Reuse.swift
//  Neon
//
//  Created by Alexey Ivankov on 31.05.2018.
//  Copyright © 2018 Norvik Bank. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    public class func reuseIdCell() -> String {
        return String(describing: self.classForCoder())
    }
    
    public class func nibCell() -> UINib{
        return UINib(nibName:String(describing: self.classForCoder()), bundle: nil)
    }
}
