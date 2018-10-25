

import Foundation

public class RPCResponce{
 
    public var id:NSNumber
    public var result:[String:Any]?
    public var allHeaderFields:[AnyHashable:Any]?
    
    public init?(json:[String:Any]){
        
        if let id:NSNumber = json["id"] as? NSNumber, let result = json["result"] as? [String:Any]{
            self.id = id
            self.result = result
        }
        else{
           return nil
        }
    }
}
