//
//  FileDirectorAssembly.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 11/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import Cocaine

@objc(FileDirectorAssembly )
public class FileDirectorAssembly : AssemblyProviderImpl {
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IFileDirector.self,
                             memoryPolicy: MemoryPolicy.Strong,
                             instanceScope: InstanceScope.New,
                             buildBlock: { (injector:I_Injector) -> AnyObject in
                                
                                let db:IDataBase = injector.tryInject()!
                                let network:INetwork = injector.tryInject()!
                                let sessionService:ISessionService = injector.tryInject()!
                                
                                let diskService = FileDiskService(nameWorkingFolder: "imh_corp")
                                let dataStorage = FileDataStorage(db: db)
                                
            
                                let fileDirector:IFileDirector = FileDirector(sessionService: sessionService,
                                                                              diskService: diskService,
                                                                              network: network,
                                                                              dataStorage: dataStorage)
            
                                return fileDirector
        })
    }
    
    public override static func buildType() -> Any {
        return IFileDirector.self
    }
}
