//
//  AuthServiceLayerAssembly.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(AuthCakeAssembly)
public class AuthCakeAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IAuthCake.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let network:INetwork = injector.tryInject()!
            let sessionService:ISessionService = SessionService()
            let securityService:ISecurityService = SecurityService()
            
            let authDirector:IAuthDirector =  AuthDirector(network: network,
                                                           securityService: securityService,
                                                           sessionService: sessionService)
            let authRouter:IAuthRouter = AuthRouter()
            
            let authCake = AuthCake(authDirector: authDirector,
                                    authRouter: authRouter)
            
            return authCake
        })
    }
    
    public override static func buildType() -> Any {
        return IAuthCake.self
    }
}
