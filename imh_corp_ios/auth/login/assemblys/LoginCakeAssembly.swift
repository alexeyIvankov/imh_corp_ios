//
//  LoginCakeAssembly.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(LoginCakeAssembly)
public class LoginCakeAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:ILoginCake.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let appDesign:IAppDesign = injector.tryInject()!
            let authService:IAuthService = injector.tryInject()!
            let loaderService:ILoaderService = injector.tryInject()!
            let securityService:ISecurityService = injector.tryInject()!
            
            let loginCake:ILoginCake = LoginCake(router: LoginRouter(loaderService: loaderService),
                                                 service: LoginServiceLayer(authSerice: authService, securityService:securityService),
                                                 design: LoginDesign(appDesign: appDesign))
            
            return loginCake
        })
    }
    
    public override static func buildType() -> Any {
        return ILoginCake.self
    }
}
