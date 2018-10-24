//
//  ValidatorTemplate.swift
//  Neon
//
//  Created by Alexey Ivankov on 16.03.2018.
//  Copyright © 2018 Norvik Bank. All rights reserved.
//

import Foundation

class ValidatorTemplate<Type> {
    
    private var regularExpression:((Type?)->(Bool))?
    private let value:Type?
    
    required init(value:Type?){
        self.value = value
    }
    
    public func validate(handler:@escaping (Bool)->()){

        let isValid:Bool? = regularExpression?(value)
        
        if isValid  != nil{
            handler(isValid!)
        }
        else {
            handler(false)
        }
    }
    
    public func setRegularExpression(regularExpression:@escaping (Type?)->(Bool)){
        self.regularExpression = regularExpression
    }
}
