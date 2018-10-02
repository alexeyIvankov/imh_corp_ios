//
//  UIColor+Hex.swift
//  PlatoonCore
//
//  Created by Alexander Ivlev on 11.01.2018.
//  Copyright © 2018 Ronte Ltd. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    /// convert hex string to color
    /// support formats: RGB or RGBA
    convenience public init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        
        let a, r, g, b: UInt32
        switch hex.count {
        case 6: // RGB (24-bit)
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8: // RGBA (32-bit)
            (r, g, b, a) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            assert(false, "incorrect hex string format")
            (r, g, b, a) = (255, 0, 0, 0)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    /// return hex string in format: #RGBA
    public var hexString: String {
        guard let components = cgColor.components else {
            assert(false, "can't get component for make hex string")
            return "#00000000"
        }
        
        let r = lroundf(Float(components[0] * 255))
        let g = lroundf(Float(components[1] * 255))
        let b = lroundf(Float(components[2] * 255))
        let a = lroundf(Float(components[3] * 255))
        
        return String(format: "#%02lX%02lX%02lX%02lX", r, g, b, a)
    }
}
