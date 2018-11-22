//
//  IAuthServices.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 22.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IAuthDirector : AnyObject {

    func isAuth() -> Bool
    
    func authorization(phone:String,
                       countyCode:String,
                       smsCode:String,
                       deviceId:String,
                       success:@escaping (ISession)->(),
                       error:@escaping (IError)->())
    
    func sendVerifyCode(phone:String,
                        countyCode:String,
                        deviceId:String,
                        success:@escaping (String?)->(),
                        error:@escaping (IError)->())
}
