//
//  NewsDetailsAssembly.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(NewsDetailsCakeAssembly)
public class NewsDetailsCakeAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:INewsDetailsCake.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let appDesign:IAppDesign = injector.tryInject()!
            let loaderService:ILoaderService = injector.tryInject()!

            let network:INetwork = injector.tryInject()!
            let db:IDataBase = injector.tryInject()!
            let sessionService:ISessionService = injector.tryInject()!
            let dataStorage:INewsDataStorage = NewsDataStorage(db: db)


            let router = NewsDetailsRouter(loaderService: loaderService)
            let director = NewsDetailsDirector(network: network, dataStorage: dataStorage, session:sessionService.activeSession!)
            let design = NewsDetailsDesign(appDesign: appDesign)

            let cake:INewsDetailsCake = NewsDetailsCake(router: router,
                                                        director:director,
                                                        design: design)

            return cake
        })
    }
    
    public override static func buildType() -> Any {
        return INewsDetailsCake.self
    }
}
