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
            let loaderService:ILoaderService = injector.tryInject()!
            
            let router = LoginRouter(loaderService: loaderService)
            let director = LoginDirector()
            let design = LoginDesign(appDesign: appDesign)
            
            let loginCake:ILoginCake = LoginCake(router: router,
                                                 director:director,
                                                 design: design)
            
            return loginCake
        })
    }
    
    public override static func buildType() -> Any {
        return ILoginCake.self
    }
}
