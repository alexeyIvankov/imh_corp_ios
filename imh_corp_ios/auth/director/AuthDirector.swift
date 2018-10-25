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
    
    func authorization(countryCode:String,
                       phone:String,
                       success:@escaping (IAccount)->(),
                       error:@escaping (IError)->()){
        
        self.network.apiDirector.authModule.authorization(countryCode: countryCode,
                                                          phonePart: phone,
                                                          success: { (responce) in
            
        }) { (error) in
            
        }
    }
}
