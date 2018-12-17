//
//  ServiceGroupsAssembly.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 14/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(ServiceGroupsAssembly)
public class ServiceGroupsAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IServiceGroups.self,
                             memoryPolicy: MemoryPolicy.Strong,
                             instanceScope: InstanceScope.Singleton,
                             buildBlock: { (injector:I_Injector) -> AnyObject in
                                
                                let network:INetwork = injector.tryInject()!
                                let db:IDataBase = injector.tryInject()!
                                let sessionService:ISessionService = injector.tryInject()!
                                let dataStorage:IListGroupsDataStorage = ListGroupsDataStorage(db: db)
                                
                                let serviceGroups:IServiceGroups = ServiceGroups(network: network,
                                                                           dataStorage: dataStorage,
                                                                           sessionService: sessionService)
                                
                                return serviceGroups
                                
        })
    }
    
    public override static func buildType() -> Any {
        return IServiceGroups.self
    }
}
