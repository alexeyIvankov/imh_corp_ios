//
//  Header.swift
//  LemoLink
//
//  Created by Alexey Ivankov on 05.03.2018.
//  Copyright © 2018 Business Technology. All rights reserved.
//

import Foundation
import UIKit

public class Header {
    
    public var reuseId:String
    public var nibName:String?
    public var loadClass:AnyClass?
    public var viewHeader:UIView?
    
    public init(reuseId:String, nibName:String){
        self.reuseId = reuseId
        self.nibName = nibName
    }
    
    public init(reuseId:String, loadClass:AnyClass){
        self.reuseId = reuseId
        self.loadClass = loadClass
    }
    
    public init(viewHeader:UIView){
        self.viewHeader = viewHeader
        self.reuseId = ""
    }
}
