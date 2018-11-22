//
//  IAuth.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol IAuth {
    var accessToken:String? { get }
    var refreshToken:String? { get }
}
