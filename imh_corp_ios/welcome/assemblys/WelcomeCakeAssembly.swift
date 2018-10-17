//
//  WelcomeCakeAssembly.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(WelcomeCakeAssembly)
public class WelcomeCakeAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IWelcomeCake.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let appDesign:IAppDesign = injector.tryInject()!
            
            let dataSource = WelcomePagesDataSource()
            let director:IWelcomeDirector = WelcomeDirector(dataSource: dataSource)
            let router:IWelcomeRouter = WelcomeRouter()
            let design:IWelcomeDesign = WelcomeDesign(appDesign: appDesign)
            
            let cake:IWelcomeCake = WelcomeCake(router: router,
                                                director: director,
                                                design: design)
            
            return cake
        })
    }
    
    public override static func buildType() -> Any {
        return IWelcomeCake.self
    }
}
