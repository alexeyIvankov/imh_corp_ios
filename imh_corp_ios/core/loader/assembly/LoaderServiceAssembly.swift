//
//  LoaderServiceAssembly.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 27.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

import Foundation
import Cocaine

@objc(LoaderServiceAssembly)
public class LoaderServiceAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:ILoaderService.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let loaderService:ILoaderService = LoaderService()
            
            return loaderService
        })
    }
    
    public override static func buildType() -> Any {
        return ILoaderService.self
    }
}
