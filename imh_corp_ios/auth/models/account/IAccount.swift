//
//  IAccount.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol IAccount : AnyObject {
    
    var name:String! { get }
    var position:String? { get }
    var id:String! { get }
    var phone:String! { get }
    
    func getAuth() -> IAuth
    func getSettings() -> ISettings
}
