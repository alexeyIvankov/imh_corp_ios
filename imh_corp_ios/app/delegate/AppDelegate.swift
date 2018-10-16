
import UIKit
import Fabric
import Crashlytics


class AppDelegate: UIResponder, UIApplicationDelegate, IAppDelegate {
   
    var stackWindow: IWindowStack!
    var window: UIWindow?
    
    //MARK:- Dependence
    private let authCake:IAuthCake = Depednence.tryInject()!
    
    //MARK: - UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureExternalLibary()
        buildStackWindowIfNeed()
        self.selectStartFlow()
    
        return true
    }
    
    private func selectStartFlow(){

        if self.authCake.authDirector.isAuth() {
            self.authCake.authRouter.handleEventAppAuthorized()
        }
        else {
            self.authCake.authRouter.handleEventAppNotAuthorized()
        }
    }
    
    private func configureExternalLibary(){
        //Fabric.with([Crashlytics.self])
    }
    
    private func buildStackWindowIfNeed(){
        
        guard self.stackWindow == nil, self.window != nil else {
            return
        }
        
        self.window?.rootViewController = nil
        self.stackWindow = WindowStack(win: self.window!)
        
    }
}

