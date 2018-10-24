//
//  StateType.swift
//  Neon
//
//  Created by Alexey Ivankov on 15.03.2018.
//  Copyright © 2018 Norvik Bank. All rights reserved.
//

import Foundation

public class StateType<Type:Equatable>: Equatable {
 
    let type:Type
    required public init(type:Type) {
        self.type = type
    }

    public static func ==(lhs: StateType<Type>, rhs: StateType<Type>) -> Bool {
        return lhs.type == rhs.type
    }
}
