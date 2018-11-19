//
//  DynamicAssembly.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

class DynamicAssembly:I_Assembly {
    
    var buildType: Any
    var memoryPolicy: MemoryPolicy
    var instanceScope: InstanceScope
    var instance:AnyObject
    
    required init(buildType: Any,
                  memoryPolicy: MemoryPolicy,
                  instanceScope: InstanceScope,
                  instance:AnyObject){
        self.buildType = buildType
        self.memoryPolicy = memoryPolicy
        self.instanceScope = instanceScope
        self.instance = instance
    }
    
    func build(injector: I_Injector) -> AnyObject {
        return self.instance
    }
    
}
