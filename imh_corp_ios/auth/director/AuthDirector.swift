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
    
    required init( network:INetwork){
        self.network = network
    }
    
    func isAuth() -> Bool{
        return false
    }
    
    func authorization(phone:String,
                       countyCode:String,
                       smsCode:String,
                       deviceId:String,
                       success:@escaping (IAccount)->(),
                       error:@escaping (IError)->()){
        
        self.network.apiDirector.authModule.authorization(phone: phone,
                                                          deviceId: deviceId,
                                                          countryCode:countyCode,
                                                          smsCode: smsCode,
                                                          success: { (responce) in
            print(responce)
            
        }) { (error) in
           print(error)
        }
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
