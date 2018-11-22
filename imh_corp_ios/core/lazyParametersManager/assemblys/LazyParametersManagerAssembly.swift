import Foundation 
import Cocaine

@objc(LazyParametersManagerAssembly)
public class LazyParametersManagerAssembly : AssemblyProviderImpl {

    public override func assembly() -> I_Assembly? {
     
        return Assembly.init(buildType:ILazyParametersManager.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
        
            let lazyParametersManager:ILazyParametersManager = LazyParametersManager()
            return lazyParametersManager
        })
    }
    
    public override static func buildType() -> Any {
        return ILazyParametersManager.self
    }
 }
