//
//  UIViewBottomBorder.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 23/10/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

@IBDesignable
class UIViewDrawBorder : UIView{
    
    
    @IBInspectable public var bottomBorder:Bool  = false
    @IBInspectable public var topBorder:Bool  = false
    @IBInspectable public var leftBorder:Bool  = false
    @IBInspectable public var rightBorder:Bool  = false
    @IBInspectable public var colorBorder:UIColor  = UIColor.lightGray
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if self.bottomBorder == true{
            self.drawBottomBorder()
        }
        
        if self.topBorder == true{
            self.drawTopBorder()
        }
        
        if self.leftBorder == true{
            self.drawLeftBorder()
        }
        
        if self.rightBorder == true{
            self.drawRightBorder()
        }
    }
    
    
    private func drawBottomBorder(){
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(self.colorBorder.cgColor)
        context?.setLineWidth(0.5)
        
        context?.move(to: CGPoint(x: 0, y: self.frame.size.height))
        context?.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        
        context?.strokePath()
    }
    
    private func drawTopBorder(){
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(self.colorBorder.cgColor)
        context?.setLineWidth(0.5)
        
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: self.frame.size.width, y: 0))
        
        context?.strokePath()
        
    }
    
    private func drawLeftBorder(){
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(self.colorBorder.cgColor)
        context?.setLineWidth(0.5)
        
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
        
        context?.strokePath()
        
    }
    
    private func drawRightBorder(){
        
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(self.colorBorder.cgColor)
        context?.setLineWidth(0.5)
        
        context?.move(to: CGPoint(x: self.frame.size.width, y: 0))
        context?.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        
        context?.strokePath()
    }
}
