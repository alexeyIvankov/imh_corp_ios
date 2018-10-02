//
//  LoginCakeAssembly.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(AppDesignAssembly)
public class AppDesignAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IAppDesign.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let appDesign:IAppDesign = AppDesign()
            
            return appDesign
        })
    }
    
    public override static func buildType() -> Any {
        return IAppDesign.self
    }
}
