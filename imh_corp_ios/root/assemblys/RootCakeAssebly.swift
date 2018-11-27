//
//  RootServiceLayerAssebly.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 23.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

import Foundation
import Cocaine

@objc(RootCakeAssembly)
public class RootCakeAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IRootCake.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let appDesign:IAppDesign = injector.tryInject()!
            let design:IRootDesign = RootDesign(appDesign: appDesign)
            
            let securityService:ISecurityService = injector.tryInject()!
            let loaderService:ILoaderService = injector.tryInject()!

            let rootServiceLayer:IRootDirector = RootDirector(securityService: securityService)
            let rootRouter:IRootRouter = RootRouter(loaderService: loaderService)
            
            let cake:IRootCake = RootCake(router: rootRouter,
                                          serviceLayer: rootServiceLayer,
                                          design:design)
            
            return cake
        })
    }
    
    public override static func buildType() -> Any {
        return IRootCake.self
    }
}
