

import Foundation
import Alamofire

extension SessionManager {
    
    func buildRPCRequest(url:URLConvertible,
                   method:String,
                   params:[String: Any]) -> DataRequest {
        

        return request(url, method: .post, parameters: createPayloadRPC(method: method, params: params), encoding: JSONEncoding.default, headers: nil)
    }
    
    private func createPayloadRPC(method:String, params:[String: Any]) -> [String:Any]{
        
        var payload:[String:Any] = [:]
        
        let version:String = "2.0"
        let id = 1
        
        payload["jsonrpc"] = (version as AnyObject)
        payload["method"] = (method as AnyObject)
        payload["params"] = (params as AnyObject)
        payload["id"] = (id as AnyObject)
        
        return payload
    }
}



