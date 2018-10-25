

import Foundation
import Alamofire

extension DataRequest {
    
    public func rpcResponse(success:@escaping (RPCResponce)->(), failed: @escaping (NSError)->())
    {
        self.responseJSON { (dataResponce) in
            
            let json = self.tryEjectJsonFrom(responce: dataResponce)
            
            if json != nil {
                
                if let errorDict = json!["error"] as? [String:Any],
                    let message = errorDict["message"] as? String,
                    let code = errorDict["code"] as? NSNumber{
                    failed(NSError(domain: message, code: code.intValue, userInfo: nil))
                }
                else {
                    
                    let rpcResponce:RPCResponce? = RPCResponce(json:json!)
                    rpcResponce?.allHeaderFields = self.response?.allHeaderFields
                    
                    if rpcResponce != nil
                    {
                        success(rpcResponce!)
                    }
                    else
                    {
                        failed(NSError(domain: "failed create responce", code: -1, userInfo: nil))
                    }
                }
                
            }
            else
            {
                failed(NSError(domain: "failed pasre json", code: -1, userInfo: nil))
            }
        }
    }
    
    
    private func tryEjectJsonFrom(responce:DataResponse<Any>) -> Dictionary<String, Any>?{
        
        var ejectedJson:Dictionary<String, Any>?
        
        switch responce.result
        {
        case .success(let value):
            if let _ = responce.response
            {
                if let json:Dictionary<String, Any> = value as? Dictionary<String, Any>{
                    ejectedJson = json
                }
            }
            break
            
        case .failure(_):
            break
            
        }
        
        return ejectedJson
    }

}











