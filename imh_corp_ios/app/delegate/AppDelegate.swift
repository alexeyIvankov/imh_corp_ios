
import UIKit
import Fabric
import Crashlytics


class AppDelegate: UIResponder, UIApplicationDelegate, IAppDelegate {
   
    var stackWindow: IWindowStack!
   
    var window: UIWindow? {
        didSet
        {
            if self.window != nil{
                self.window?.rootViewController = nil
                self.stackWindow = WindowStack(win: self.window!)
            }
        }
    }
    
    //MARK:- Dependence
    private let authCake:IAuthCake = Depednence.tryInject()!
    
    //MARK: - UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureExternalLibary()
        self.selectEntryPointApp()
    
        return true
    }
    
    private func selectEntryPointApp(){

        if self.authCake.authDirector.isAuth() {
            self.authCake.authRouter.startAppWithAuthorized()
        }
        else {
            self.authCake.authRouter.startAppNotAuthorized()
        }
    }
    
    private func configureExternalLibary(){
        //Fabric.with([Crashlytics.self])
    }
}

