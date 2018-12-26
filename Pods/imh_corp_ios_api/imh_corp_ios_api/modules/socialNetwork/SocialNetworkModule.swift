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
        case getAllGroups = "get_all_groups"
        case getAllNews = "get_all_news"
        case getNewsSelectedGroups = "get_news_selected_groups"
        case getNewsExceptGroups = "get_news_except_groups"
        case getAttach = "get_attach"
        case getImage = "get_image"
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
        
        self.requestExecutor.createRPCRequest(url: self.url, method:RemoteMethods.getAllGroups.rawValue , params: params).rpcResponse(success: success, failed: failed)
    }
    
    public func allNews(accessToken:String,
                        networkType:String,
                        startDate:Int?,
                        endDate:Int?,
                        countMessages:Int?,
                        success:@escaping (RPCResponce)->(),
                        failed:@escaping (NSError)->()){
        
        var params:[String:Any] = [:]
        params["access_token"] = accessToken
        params["network_type"] = networkType
        
        if startDate != nil{
            params["start_date"] = startDate!
        }
        
        if endDate != nil{
            params["end_date"] = endDate!
        }
        
        if countMessages != nil{
            params["count"] = countMessages!
        }
        
        self.requestExecutor.createRPCRequest(url: self.url, method:RemoteMethods.getAllNews.rawValue , params: params).rpcResponse(success: success, failed: failed)
    }
    
    public func newsSelectedGroups(accessToken:String,
                                   networkType:String,
                                   groupsIdList:[Int],
                                   startDate:Int?,
                                   endDate:Int?,
                                   countMessages:Int?,
                                   success:@escaping (RPCResponce)->(),
                                   failed:@escaping (NSError)->()){
        
        var params:[String:Any] = [:]
        params["access_token"] = accessToken
        params["network_type"] = networkType
        
        if startDate != nil{
            params["start_date"] = startDate!
        }
        
        if endDate != nil{
            params["end_date"] = endDate!
        }
        
        if countMessages != nil{
            params["count"] = countMessages!
        }
        
        params["selected_groups"] = groupsIdList
        
        self.requestExecutor.createRPCRequest(url: self.url, method:RemoteMethods.getNewsSelectedGroups.rawValue , params: params).rpcResponse(success: success, failed: failed)
        
    }
    
    public func newsExceptGroups(accessToken:String,
                                 networkType:String,
                                 groupsIdList:[Int],
                                 startDate:Int?,
                                 endDate:Int?,
                                 countMessages:Int?,
                                 success:@escaping (RPCResponce)->(),
                                 failed:@escaping (NSError)->()){
        
        var params:[String:Any] = [:]
        params["access_token"] = accessToken
        params["network_type"] = networkType
        
        if startDate != nil{
            params["start_date"] = startDate!
        }
        
        if endDate != nil{
            params["end_date"] = endDate!
        }
        
        if countMessages != nil{
            params["count"] = countMessages!
        }
        
        params["except_groups"] = groupsIdList
        
        self.requestExecutor.createRPCRequest(url: self.url, method:RemoteMethods.getNewsExceptGroups.rawValue , params: params).rpcResponse(success: success, failed: failed)
        
    }
    
    public func attach(accessToken:String,
                networkType:String,
                attachUrl:String,
                success:@escaping (Data)->(),
                failed:@escaping (NSError)->()){
        
        var params:[String:Any] = [:]
        params["access_token"] = accessToken
        params["network_type"] = networkType
        params["url"] = attachUrl
        
        self.requestExecutor.createRPCRequest(url: self.url, method: RemoteMethods.getAttach.rawValue, params: params).responseData { (responce) in
            
            switch responce.result {
                
            case .success(let value): do {
                success(value)
                }
                
            case .failure(let error): do{
                failed(NSError(domain: error.localizedDescription, code: -1, userInfo: nil))
                }
            }
        }
    }
    
    public func image(accessToken:String,
                      networkType:String,
                      imageUrl:String,
                      width:Int,
                      height:Int,
                      success:@escaping (Data)->(),
                      failed:@escaping (NSError)->()){
        
        var params:[String:Any] = [:]
        params["access_token"] = accessToken
        params["network_type"] = networkType
        params["url"] = imageUrl
        params["width"] = width
        params["height"] = height
        
        self.requestExecutor.createRPCRequest(url: self.url, method: RemoteMethods.getImage.rawValue, params: params).responseData { (responce) in
            
            switch responce.result {
                
            case .success(let value): do {
                success(value)
                }
                
            case .failure(let error): do{
                failed(NSError(domain: error.localizedDescription, code: -1, userInfo: nil))
                }
            }
        }
        
    }

}
