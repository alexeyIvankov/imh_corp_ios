//
//  UIView+Shadow.swift
//  Neon
//
//  Created by Alexey Ivankov on 11.04.2018.
//  Copyright © 2018 Norvik Bank. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func addShadow(color:UIColor,
                   offset:CGSize? = nil,
                   radius:CGFloat? = nil,
                   opacity:Float? = nil) {
     
        self.layer.shadowColor =  color.cgColor
        
        if opacity != nil{
            self.layer.shadowOpacity = opacity!
        }
        else {
            self.layer.shadowOpacity = 0.5
        }
        
        if offset != nil{
            self.layer.shadowOffset = offset!
        }
        else {
            self.layer.shadowOffset = CGSize.zero
        }
        
        if radius != nil{
            self.layer.shadowRadius = radius!
        }
        else {
            self.layer.shadowRadius = 10
        }
        
        self.layer.masksToBounds = false
    }
}
