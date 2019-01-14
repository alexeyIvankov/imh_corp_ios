//
//  IEvent.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 10/01/2019.
//  Copyright © 2019 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol IEvent : AnyObject{
    
    var type:String { get }
    var name:String? { get }
    var handler:String? { get }
    var address:String? { get }
    var date:NSNumber { get }
    var dateText:String? { get }
}
