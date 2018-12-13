

import Foundation
import UIKit
import Cocaine

public class MyApplication{
    
    public class func application() -> IApplication{
        return UIApplication.shared as! IApplication
    }
    
    public class func delegate() -> IAppDelegate?{
        return self.application().appDelegate
    }
}

public class Depednence{
    
    public class func tryInject<T>() -> T?{
        return MyApplication.application().dependenceDirector.tryInject()
    }
    
    public class func tryRegister(assembly:I_Assembly) throws {
        try MyApplication.application().dependenceDirector.tryRegister(assembly: assembly)
    }
}


public func asynchMain(block:@escaping()->()){
    DispatchQueue.main.async(execute: block)
}

public func generateError(message:String) -> NSError{
    return NSError(domain: message, code: -1, userInfo: nil)
}
