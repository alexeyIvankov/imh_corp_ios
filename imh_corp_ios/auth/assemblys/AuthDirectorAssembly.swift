import Foundation 
import Cocaine

@objc(AuthServiceAssembly)
public class AuthDirectorAssembly : AssemblyProviderImpl {

    public override func assembly() -> I_Assembly? {
     
        return Assembly.init(buildType:IAuthDirector.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
        
            let network:INetwork = injector.tryInject()!
            let sessionService:ISessionService = SessionService()
            let authDirector:IAuthDirector = AuthDirector(network: network,
                                                          securityService: SecurityService(),
                                                          sessionService: sessionService)
            return authDirector
        })
    }
    
    public override static func buildType() -> Any {
        return IAuthDirector.self
    }
 }
