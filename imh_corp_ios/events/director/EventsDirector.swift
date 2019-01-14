//
//  LoginDirector.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class EventsDirector : IEventsDirector {
    
    var eventService:IEventService
    
    required init(eventService:IEventService) {
        self.eventService = eventService
    }
  
}
