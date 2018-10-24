//
//  LoginCakeAssembly.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(СompanyServicesCakeAssembly)
public class СompanyServicesCakeAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IСompanyServicesCake.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let appDesign:IAppDesign = injector.tryInject()!
            let loaderService:ILoaderService = injector.tryInject()!
            
            let router = СompanyServicesRouter(loaderService: loaderService)
            let director = СompanyServicesDirector()
            let design = СompanyServicesDesign(appDesign: appDesign)
            
            let cake:IСompanyServicesCake = СompanyServicesCake(router: router,
                                        director:director,
                                        design: design)
            
            return cake
        })
    }
    
    public override static func buildType() -> Any {
        return IСompanyServicesCake.self
    }
}
