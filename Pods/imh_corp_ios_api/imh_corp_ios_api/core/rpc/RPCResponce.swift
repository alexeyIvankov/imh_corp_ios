

import Foundation

public class RPCResponce{
 
    public var success:[String:Any]?
    public var allHeaderFields:[AnyHashable:Any]?
    
    public init?(json:[String:Any]){
        
        if let success = json["success"] as? [String:Any]{
            self.success = success
        }
        else{
           return nil
        }
    }
}
