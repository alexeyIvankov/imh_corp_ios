//
//  LoginCakeAssembly.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(ConfirmationCakeAssembly)
public class ConfirmationCakeAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IConfirmationCake.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let appDesign:IAppDesign = injector.tryInject()!
            let loaderService:ILoaderService = injector.tryInject()!
            
            let router = ConfirmationRouter(loaderService: loaderService)
            let director = ConfirmationDirector()
            let design = ConfirmationDesign(appDesign: appDesign)
            
            let cake:IConfirmationCake = ConfirmationCake(router: router,
                                                          director:director,
                                                          design: design)
            
            return cake
        })
    }
    
    public override static func buildType() -> Any {
        return IConfirmationCake.self
    }
}
