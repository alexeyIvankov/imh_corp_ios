//
//  Auth.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 03/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class Auth : IAuth {
    var accessToken: String?
    var refreshToken: String?
    
    required init(auth:IAuth) {
        self.accessToken = auth.accessToken
        self.refreshToken = auth.refreshToken
    }
    
}
