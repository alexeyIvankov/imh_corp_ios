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
        case allNews = "all_news"
        case getAttach = "attach"
        case getImage = "image"
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
        
        self.requestExecutor.createRPCRequest(url: self.url, method:RemoteMethods.allGroups.rawValue , params: params).rpcResponse(success: success, failed: failed)
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
        
        self.requestExecutor.createRPCRequest(url: self.url, method:RemoteMethods.allNews.rawValue , params: params).rpcResponse(success: success, failed: failed)
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
