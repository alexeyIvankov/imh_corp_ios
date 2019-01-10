//
//  LoginCakeAssembly.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(EmployeeRequestsCakeAssembly)
public class EmployeeRequestsCakeAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IEmployeeRequestsCake.self,
                             memoryPolicy: MemoryPolicy.Strong,
                             instanceScope: InstanceScope.Singleton,
                             buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let appDesign:IAppDesign = injector.tryInject()!
            let loaderService:ILoaderService = injector.tryInject()!
            let serviceEmployeeRequests:IEmployeeRequestService = EmployeeRequestService()
            
            let router = EmployeeRequestsRouter(loaderService: loaderService)
                                let director = EmployeeRequestsDirector(serviceEmployeeRequests: serviceEmployeeRequests)
            let design = EmployeeRequestsDesign(appDesign: appDesign)
            
            let cake:IEmployeeRequestsCake = EmployeeRequestsCake(router: router,
                                        director:director,
                                        design: design)
            
            return cake
        })
    }
    
    public override static func buildType() -> Any {
        return IEmployeeRequestsCake.self
    }
}
