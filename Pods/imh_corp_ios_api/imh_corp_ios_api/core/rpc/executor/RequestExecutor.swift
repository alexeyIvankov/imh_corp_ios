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
    
    required init(sessionManager:SessionManager) {
        self.sessionManager = sessionManager
    }
    
    
    public func createRPCRequest(url:URLConvertible,
                                 method:String,
                                 params:[String: Any]) -> DataRequest{
        return self.sessionManager.buildRPCRequest(url: url, method: method, params: params)
    }
}
