

import Foundation
import UIKit

class Application : UIApplication, IApplication {
   
    //MARK: - DependenceDirector
    internal var dependenceDirector:IDependenceDirector = DependenceDirector()
    
    //MARK: - AppDelegate
    private(set) lazy var appDelegate: IAppDelegate? = self.delegate as? IAppDelegate
    
    //MARK: - Localizator
    var localizator: ILocalizator = Localizator()
    
    //MARK: - memory managment
    override init(){
        super.init()
    }
    
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
    }
}
