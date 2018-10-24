//
//  StateEngineTemplate.swift
//  Neon
//
//  Created by Alexey Ivankov on 15.03.2018.
//  Copyright © 2018 Norvik Bank. All rights reserved.
//

import Foundation

public class StateEngineTemplate<Type:Equatable>{
   
    public typealias type = Type
    
    public let states:[StateTemplate<Type>]
    public var currentState:StateTemplate<Type>
    
    required public init(states:[StateTemplate<Type>], currentState:StateTemplate<Type>){
        self.states = states
        self.currentState = currentState
    }
    
    public func change(stateType:StateType<Type>, data:AnyObject? = nil){
                
        for state in states{
            
            if state.type == stateType{
                currentState = state
                currentState.apply(data: data)
                break
            }
        }
    }
}
