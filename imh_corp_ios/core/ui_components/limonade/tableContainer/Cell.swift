//
//  Cell.swift
//  TableContainer
//
//  Created by Alexey Ivankov on 04.03.2018.
//  Copyright © 2018 Alexey Ivankov. All rights reserved.
//

import Foundation

public struct Cell {
    
    public var reuseId:String
    public var nibName:String?
    public var loadClass:AnyClass?
    
    public init(reuseId:String, nibName:String){
        self.reuseId = reuseId
        self.nibName = nibName
    }
    
    public init(reuseId:String, loadClass:AnyClass){
        self.reuseId = reuseId
        self.loadClass = loadClass
    }
    
}
