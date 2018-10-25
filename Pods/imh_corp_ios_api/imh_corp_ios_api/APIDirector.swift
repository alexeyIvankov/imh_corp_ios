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
        case auth = "/auth"
    }
   
    public let serverUrl:String
    
    private let sessionManager:SessionManager
    private let requestExecutor:IRequestExecutor
    
    //MARK: Modules
    public let authModule: IAuthModule
    
    public required init(serverUrl:String){
        self.serverUrl = serverUrl
        self.sessionManager = SessionManager()
        self.requestExecutor = RequestExecutor(sessionManager: self.sessionManager)
        self.authModule = AuthModule(requestExecutor: self.requestExecutor, url: self.serverUrl + PathModules.auth.rawValue)
    }
    
    
}
