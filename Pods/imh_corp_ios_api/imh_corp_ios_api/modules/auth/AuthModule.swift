//
//  AuthModule.swift
//  imh_corp_ios_api
//
//  Created by Alexey Ivankov on 25/10/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

public class AuthModule : IAuthModule{
    
    enum RemoteMethods : String{
        case authorization = "authorization"
    }
    
    let requestExecutor:IRequestExecutor
    let url:String

    required public init(requestExecutor:IRequestExecutor, url:String){
        self.requestExecutor = requestExecutor
        self.url = url
    }
    
    public func authorization(deviceId:String,
                              phone:String,
                              success:@escaping (RPCResponce)->(),
                              failed:@escaping (NSError)->()){
        
        var params:[String:Any] = [:]
        params["deviceId"] = deviceId
        params["phone"] = phone
        
        self.requestExecutor.executeRPCRequest(url: self.url, method:RemoteMethods.authorization.rawValue , params: params,success: success, failed: failed)
    }
    
}
