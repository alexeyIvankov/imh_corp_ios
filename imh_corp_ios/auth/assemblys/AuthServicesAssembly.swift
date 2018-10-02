import Foundation 
import Cocaine

@objc(AuthServiceAssembly)
public class AuthServiceAssembly : AssemblyProviderImpl {

    public override func assembly() -> I_Assembly? {
     
        return Assembly.init(buildType:IAuthService.self, memoryPolicy: MemoryPolicy.Strong, instanceScope: InstanceScope.Singleton, buildBlock: { (injector:I_Injector) -> AnyObject in
        
            let network:INetwork = injector.tryInject()!
            let sessionService:ISessionService = SessionService()
            let authService:IAuthService = AuthService(network: network,
                                                       securityService: SecurityService(),
                                                       sessionService: sessionService)
            
            return authService
        })
    }
    
    public override static func buildType() -> Any {
        return IAuthService.self
    }
 }
