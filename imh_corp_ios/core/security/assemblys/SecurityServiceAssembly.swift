//
//  SecurityServicesAssembly.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 27.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(SecurityServiceAssembly)
public class SecurityServiceAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:ISecurityService.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let securityService:ISecurityService = SecurityService()
            
            return securityService
        })
    }
    
    public override static func buildType() -> Any {
        return ISecurityService.self
    }
}
