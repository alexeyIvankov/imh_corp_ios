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
    
    func allNews(accessToken:String,
                 networkType:String,
                 startDate:Int?,
                 endDate:Int?,
                 countMessages:Int?,
                 success:@escaping (RPCResponce)->(),
                 failed:@escaping (NSError)->())
}
