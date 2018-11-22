import Foundation 
import Cocaine

@objc(NetworkAssembly)
public class NetworkAssembly : AssemblyProviderImpl {

    public override func assembly() -> I_Assembly? {
     
        return Assembly.init(buildType:INetwork.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
        
            let network:INetwork = Network(url: "https://corp-app.metholding.com")
            
            return network
        })
    }
    
    public override static func buildType() -> Any {
        return INetwork.self
    }
 }
