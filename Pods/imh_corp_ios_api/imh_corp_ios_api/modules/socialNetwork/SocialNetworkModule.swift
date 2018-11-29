//
//  SocialNetworkModule.swift
//  imh_corp_ios_api
//
//  Created by Alexey Ivankov on 21/11/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

public class SocialNetworkModule : ISocialNetworkModule{

    enum RemoteMethods : String{
        case allGroups = "all_groups"
        case messagesFromGroup = "messages_from_group"
    }
    
    let requestExecutor:IRequestExecutor
    let url:String
    
    required public init(requestExecutor:IRequestExecutor, url:String){
        self.requestExecutor = requestExecutor
        self.url = url
    }
    
    public func allGroups(accessToken: String,
                          networkType: String,
                          success: @escaping (RPCResponce) -> (),
                          failed: @escaping (NSError) -> ()) {
        
        var params:[String:Any] = [:]
        params["access_token"] = accessToken
        params["network_type"] = networkType

        self.requestExecutor.executeRPCRequest(url: self.url, method:RemoteMethods.allGroups.rawValue , params: params,success: success, failed: failed)
    }
    
    public func messagesFromGroup(groupId: String,
                                  accessToken: String,
                                  networkType: String,
                                  lastMessageId:String?,
                                  success: @escaping (RPCResponce) -> (),
                                  failed: @escaping (NSError) -> ()) {
        
        var params:[String:Any] = [:]
        params["access_token"] = accessToken
        params["network_type"] = networkType
        params["group_id"] = groupId
        
        if lastMessageId != nil{
            params["last_message_id"] = String(lastMessageId!)
        }
        
        self.requestExecutor.executeRPCRequest(url: self.url, method:RemoteMethods.messagesFromGroup.rawValue , params: params,success: success, failed: failed)
    }
}
