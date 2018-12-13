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
        case sendVerifyCode = "send_sms"
    }
    
    let requestExecutor:IRequestExecutor
    let url:String

    required public init(requestExecutor:IRequestExecutor, url:String){
        self.requestExecutor = requestExecutor
        self.url = url
    }
    
    public func authorization(phone:String,
                              deviceId:String,
                              countryCode:String,
                              smsCode:String,
                              success:@escaping (RPCResponce)->(),
                              failed:@escaping (NSError)->()){
        
        var params:[String:Any] = [:]
        params["deviceId"] = deviceId
        params["phone"] = phone
        params["country_code"] = countryCode
        params["sms_code"] = smsCode
        
        self.requestExecutor.createRPCRequest(url: self.url, method: RemoteMethods.authorization.rawValue, params: params).rpcResponse(success: success, failed: failed)
    }
    
    public func sendVerifyCode(phone: String,
                               countryCode: String,
                               deviceId: String,
                               success: @escaping (RPCResponce) -> (),
                               failed: @escaping (NSError) -> ()) {
        
        var params:[String:Any] = [:]
        params["deviceId"] = deviceId
        params["phone"] = phone
        params["country_code"] = countryCode
        
        self.requestExecutor.createRPCRequest(url: self.url, method:RemoteMethods.sendVerifyCode.rawValue , params: params).rpcResponse(success: success, failed: failed)
    }
}
