//
//  StateEngineTemplate.swift
//  Neon
//
//  Created by Alexey Ivankov on 15.03.2018.
//  Copyright © 2018 Norvik Bank. All rights reserved.
//

import Foundation

public class StateEngine<Type:Equatable>{
   
    public typealias type = Type
    
    public var states:[State<Type>]
    public var currentState:State<Type>!
    
    public init(states:[State<Type>], currentState:State<Type>){
        self.states = states
        self.currentState = currentState
    }
    
    public init (){
         self.states = []
    }
    
    public func change(stateType:StateTypeWrapper<Type>, data:AnyObject? = nil){
                
        for state in states{
            
            if state.type == stateType{
                currentState = state
                currentState.apply(data: data)
                break
            }
        }
    }
    
    public func addState(type:Type,
                         body:@escaping (AnyObject?)->()){
        
        let state = State<Type>(type: type)
        state.set(body: body)
        self.states.append(state)
    }
    
    public func changeState(type:Type, data:AnyObject? = nil){
        let typeWrapper = StateTypeWrapper(type:type)
        self.change(stateType: typeWrapper, data: data)
    }
}
