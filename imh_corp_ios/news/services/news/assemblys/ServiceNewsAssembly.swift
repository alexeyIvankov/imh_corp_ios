//
//  ServiceNewsAssembly.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 14/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(ServiceNewsAssembly)
public class ServiceNewsAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IServiceNews.self,
                             memoryPolicy: MemoryPolicy.Strong,
                             instanceScope: InstanceScope.Singleton,
                             buildBlock: { (injector:I_Injector) -> AnyObject in
                                
                                let network:INetwork = injector.tryInject()!
                                let db:IDataBase = injector.tryInject()!
                                let sessionService:ISessionService = injector.tryInject()!
                                let dataStorage:INewsDataStorage = NewsDataStorage(db: db)
            
                                let serviceNews:IServiceNews = ServiceNews(network: network,
                                                                           dataStorage: dataStorage,
                                                                           sessionService: sessionService)
                                
                                return serviceNews
            
        })
    }
    
    public override static func buildType() -> Any {
        return IServiceNews.self
    }
}
