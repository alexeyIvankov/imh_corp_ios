//
//  Event.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 10/01/2019.
//  Copyright © 2019 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class Event : IEvent {
    
    var type: String
    var name: String?
    var handler: String?
    var address: String?
    var date: NSNumber
    
    required init(type:String,
                  date:NSNumber,
                  name:String? = nil,
                  handler:String? = nil,
                  address:String? = nil){
        
        self.type = type
        self.date = date
        self.name = name
        self.handler = handler
        self.address = address
    }
    
}
