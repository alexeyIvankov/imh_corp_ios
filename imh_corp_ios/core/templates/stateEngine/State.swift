//
//  StateTemplate.swift
//  Neon
//
//  Created by Alexey Ivankov on 15.03.2018.
//  Copyright © 2018 Norvik Bank. All rights reserved.
//

import Foundation

public class State<Type:Equatable> : Equatable {
    
    var type: StateTypeWrapper<Type>
    private var stateBody:((AnyObject?)->())?

    
    required public init(type:Type){
        self.type = StateTypeWrapper<Type>(type:type)
    }
    
    public func set(body:@escaping (AnyObject?)->()){
        self.stateBody = body
    }
    
    public func apply(data:AnyObject? = nil){
        self.stateBody?(data)
    }
    
    
    public static func ==(lhs: State<Type>, rhs: State<Type>) -> Bool {
        return lhs.type  == rhs.type
    }
}
