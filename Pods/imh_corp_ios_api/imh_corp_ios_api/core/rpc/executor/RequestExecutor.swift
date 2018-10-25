//
//  RequestExecutor.swift
//  neon_api
//
//  Created by Alexey Ivankov on 28.04.2018.
//  Copyright © 2018 Norvik Bank. All rights reserved.
//

import Foundation
import Alamofire

class RequestExecutor : IRequestExecutor{
    
    let sessionManager:SessionManager
    var handlerAllResponce:((RPCResponce)->())?
    var handlerAllError:((NSError)->())?
    
    required init(sessionManager:SessionManager) {
        self.sessionManager = sessionManager
    }
    
    
    public func executeRPCRequest(url:URLConvertible,
                                  method:String,
                                  params:[String: Any],
                                  success:@escaping (RPCResponce)->(),
                                  failed: @escaping (NSError)->()){
     
        
        self.sessionManager.buildRPCRequest(url: url, method: method, params: params).rpcResponse(success: { (responce) in
            
            self.handlerAllResponce?(responce)
            success(responce)
            
        }, failed: { (error) in
            
            self.handlerAllError?(error)
            failed(error)
        })
    }
    
    public func setHandleAllResponce(handler:@escaping (RPCResponce)->()){
        self.handlerAllResponce = handler
    }
    
    func setHandleAllError(handler:@escaping (NSError)->()){
        self.handlerAllError = handler
    }
}
