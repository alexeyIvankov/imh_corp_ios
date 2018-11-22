//
//  AuthServices.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 22.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class AuthDirector : IAuthDirector {

    var network:INetwork
    var dataStorage:IAuthDataStorage
    var sessionService:ISessionService
    
    required init( network:INetwork,
                   dataStorage:IAuthDataStorage,
                   sessionService:ISessionService){
        
        self.network = network
        self.dataStorage = dataStorage
        self.sessionService = sessionService
    }
    
    func isAuth() -> Bool{
        if self.sessionService.activeSession != nil{
            return true
        }
        else {
            return false
        }
    }
    
    func authorization(phone:String,
                       countyCode:String,
                       smsCode:String,
                       deviceId:String,
                       success:@escaping (ISession)->(),
                       error:@escaping (IError)->()){
        
        self.network.apiDirector.authModule.authorization(phone: phone,
                                                          deviceId: deviceId,
                                                          countryCode:countyCode,
                                                          smsCode: smsCode,
                                                          success: { (responce) in
                                                           
                                                            if let data = responce.success?["data"] as? [String:Any], let account = data["account"] as? [String:Any]{
                                                                self.dataStorage.trySaveAuthorization(account: account)
                                                                
                                                                if let session = self.sessionService.activeSession{
                                                                    success(session)
                                                                }
                                                                else {
                                                                    error(NSError(domain: "Не удалось получить информацию о пользователе!", code: -1, userInfo: nil))
                                                                }
                                                               
                                                                
                                                            }
                                                            else{
                                                                error(NSError(domain: "Не удалось получить информацию о пользователе!", code: -1, userInfo: nil))
                                                            }
                                         
            
        }, failed:error)
    }
    
    func sendVerifyCode(phone:String,
                        countyCode:String,
                        deviceId:String,
                        success:@escaping (String?)->(),
                        error:@escaping (IError)->()){
        
        self.network.apiDirector.authModule.sendVerifyCode(phone: phone,
                                                           countryCode: countyCode,
                                                           deviceId: deviceId,
                                                           success: { (responce) in
             
                                                            if let responceSuccess = responce.success?["data"] as? [String:Any],
                                                                let message = responceSuccess["message"] as? String{
                                                                success(message)
                                                            }
                                                            else{
                                                                success(nil)
                                                            }
                                                            
        }, failed:error)
    }
}
