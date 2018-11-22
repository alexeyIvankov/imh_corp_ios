//
//  IAuthModule.swift
//  imh_corp_ios_api
//
//  Created by Alexey Ivankov on 25/10/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

public protocol IAuthModule : AnyObject{
    
    func authorization(phone:String,
                       deviceId:String,
                       countryCode:String,
                       smsCode:String,
                       success:@escaping (RPCResponce)->(),
                       failed:@escaping (NSError)->())
    
    func sendVerifyCode(phone:String,
                        countryCode:String,
                        deviceId:String,
                        success:@escaping (RPCResponce)->(),
                        failed:@escaping (NSError)->())
}
