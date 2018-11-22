//
//  ISession.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 22/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol ISession : AnyObject {
    
    var name:String? { get }
    var dateCreated:String? { get }
    var lastUpdate:String? { get }
    
    func getAccount() -> IAccount
}
