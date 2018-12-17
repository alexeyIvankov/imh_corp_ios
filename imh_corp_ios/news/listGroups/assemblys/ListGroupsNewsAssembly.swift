//
//  NewsDetailsAssembly.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(ListGroupsNewsCakeAssembly)
public class ListGroupsNewsCakeAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IListGroupsNewsCake.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let appDesign:IAppDesign = injector.tryInject()!
            let loaderService:ILoaderService = injector.tryInject()!
            let sessionService:ISessionService = injector.tryInject()!
            let serviceGroups:IServiceGroups = injector.tryInject()!

            let network:INetwork = injector.tryInject()!
            let db:IDataBase = injector.tryInject()!
            
            let dataStorage:INewsDataStorage = NewsDataStorage(db: db)

            let router = ListGroupsNewsRouter(loaderService: loaderService)
            
            let director = ListGroupsNewsDirector(network: network,
                                                  dataStorage: dataStorage, sessionService:sessionService,
                                                  serviceGroups: serviceGroups)
            
            let design = ListGroupsNewsDesign(appDesign: appDesign)

            let cake:IListGroupsNewsCake = ListGroupsNewsCake(router: router,
                                                        director:director,
                                                        design: design)

            return cake
        })
    }
    
    public override static func buildType() -> Any {
        return IListGroupsNewsCake.self
    }
}
