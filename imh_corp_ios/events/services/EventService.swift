//
//  EventServices.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 10/01/2019.
//  Copyright © 2019 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class EventService : IEventService {
    
    func getFakeAllEvents() -> [IEvent]{
        
        let jubileePolema = Event(type: "holiday", date: NSNumber(value: 12345), name: "Юбилей предприятия", handler: "ПОЛЕМА", address: nil, dateText:"Вт, 2 окт.")
        
        let birthdayPankratov = Event(type: "birthday", date: NSNumber(value: 12345), name: "День Рождения", handler: "Евгений Панкратов", address: nil, dateText:"Ср, 3 окт.")
        
        let holidaySteelMaker = Event(type: "holiday", date: NSNumber(value: 12345), name: "День Сталевара", handler: "ПОЛЕМА", address: nil, dateText:"Чт, 4 окт.")
        
        let holidayOpenFactory = Event(type: "holiday", date: NSNumber(value: 12345), name: "Открытие завода", handler: "ПОЛЕМА", address: nil, dateText:"Пт, 5 окт.")
        
        let birthdayIvankov = Event(type: "birthday", date: NSNumber(value: 12345), name: "День рождения", handler: "ПОЛЕМА", address: nil, dateText:"Пт, 5 окт.")
        
        
        return [jubileePolema,
                birthdayPankratov,
                holidaySteelMaker,
                holidayOpenFactory,
                birthdayIvankov]
    }
    
    func getFakeEventsToday() -> [IEvent]{
        
         let jubileePolema = Event(type: "holiday", date: NSNumber(value: 12345), name: "Юбилей предприятия", handler: "ПОЛЕМА", address: nil, dateText:"Вт, 2 окт.")
        
          let holidayOpenFactory = Event(type: "holiday", date: NSNumber(value: 12345), name: "Открытие завода", handler: "ПОЛЕМА", address: nil, dateText:"Пт, 5 окт.")
        
        return [jubileePolema,
                holidayOpenFactory]
    }
}
