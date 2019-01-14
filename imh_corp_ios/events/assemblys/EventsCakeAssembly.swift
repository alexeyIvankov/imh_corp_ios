//
//  LoginCakeAssembly.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(EventsCakeAssembly)
public class EventsCakeAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IEventsCake.self,
                             memoryPolicy: MemoryPolicy.Strong,
                             instanceScope: InstanceScope.Singleton,
                             buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let eventService:IEventService = EventService()
            let appDesign:IAppDesign = injector.tryInject()!
            let loaderService:ILoaderService = injector.tryInject()!
            
            let router = EventsRouter(loaderService: loaderService)
            let director = EventsDirector(eventService: eventService)
            let design = EventsDesign(appDesign: appDesign)
            
            let cake:IEventsCake = EventsCake(router: router,
                                              director:director,
                                              design: design)
            
            return cake
        })
    }
    
    public override static func buildType() -> Any {
        return IEventsCake.self
    }
}
