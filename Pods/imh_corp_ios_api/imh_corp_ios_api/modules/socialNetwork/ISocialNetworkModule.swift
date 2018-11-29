//
//  ISocialNetworkModule.swift
//  imh_corp_ios_api
//
//  Created by Alexey Ivankov on 21/11/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

public protocol ISocialNetworkModule : AnyObject{
    
    func allGroups(accessToken:String,
                   networkType:String,
                   success:@escaping (RPCResponce)->(),
                   failed:@escaping (NSError)->())
    
    func messagesFromGroup(groupId:String,
                           accessToken:String,
                           networkType:String,
                           lastMessageId:String?,
                           success:@escaping (RPCResponce)->(),
                           failed:@escaping (NSError)->())
}