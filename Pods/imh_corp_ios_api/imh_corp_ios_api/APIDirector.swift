//
//  APIDirector.swift
//  imh_corp_ios_api
//
//  Created by Alexey Ivankov on 25/10/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
import Alamofire

public class APIDirector: IAPIDirector{
    
    enum PathModules:String{
        case auth = "/authorization/rpc/"
        case socialNetwork = "/social_network/rpc/"
    }
   
    public let serverUrl:String
    
    private let sessionManager:SessionManager
    private let requestExecutor:IRequestExecutor
    
    //MARK: Modules
    public let authModule: IAuthModule
    public let socialNetworkModule:ISocialNetworkModule
    
    public required init(serverUrl:String){
        self.serverUrl = serverUrl
        self.sessionManager = SessionManager()
        self.requestExecutor = RequestExecutor(sessionManager: self.sessionManager)
        self.authModule = AuthModule(requestExecutor: self.requestExecutor, url: self.serverUrl + PathModules.auth.rawValue)
        self.socialNetworkModule = SocialNetworkModule(requestExecutor: self.requestExecutor, url: self.serverUrl + PathModules.socialNetwork.rawValue)
    }
    
    
}
