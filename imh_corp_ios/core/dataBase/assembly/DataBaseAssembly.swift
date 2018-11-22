

import Foundation
import Cocaine

@objc(DataBaseAssembly)
class DataBaseAssembly : AssemblyProviderImpl{
 
    
    public override func assembly() -> I_Assembly? {
        
        return Assembly.init(buildType:IDataBase.self,
                             memoryPolicy: MemoryPolicy.Strong,
                             instanceScope: InstanceScope.Singleton,
                             buildBlock: { (injector:I_Injector) -> AnyObject in
            
            let db:IDataBase = DataBase()
            return db
        })
    }
    
    public override static func buildType() -> Any {
        return IDataBase.self
    }
}
