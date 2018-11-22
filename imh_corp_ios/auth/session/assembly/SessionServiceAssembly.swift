//
//  SessionServiceAssembly.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 22/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(SessionServiceAssembly)
class SessionServiceAssembly : AssemblyProviderImpl{
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:ISessionService.self,
                             memoryPolicy: MemoryPolicy.Strong,
                             instanceScope: InstanceScope.Singleton,
                             buildBlock: { (injector:I_Injector) -> AnyObject in
                                
                                let dataBase:IDataBase = injector.tryInject()!
                                let sessionService:ISessionService = SessionService(dataBase: dataBase)
                                
                                return sessionService
        })
    }
    
    public override static func buildType() -> Any {
        return ISessionService.self
    }
}
