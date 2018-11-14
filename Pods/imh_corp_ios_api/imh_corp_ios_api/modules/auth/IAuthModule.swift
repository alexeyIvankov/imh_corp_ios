//
//  IAuthModule.swift
//  imh_corp_ios_api
//
//  Created by Alexey Ivankov on 25/10/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

public protocol IAuthModule : AnyObject{
    
    func authorization(deviceId:String,
                       phone:String,
                       success:@escaping (RPCResponce)->(),
                       failed:@escaping (NSError)->())
}
