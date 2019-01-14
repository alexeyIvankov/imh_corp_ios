//
//  EventServices.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 10/01/2019.
//  Copyright © 2019 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class EventServices : IEventServices {
    
    func getFakeEvents() -> [IEvent]{
        
        let jubileePolema = Event(type: "holiday", date: NSNumber(value: 12345), name: "Юбилей предприятия", handler: "ПОЛЕМА", address: nil)
        
        let birthdayPankratov = Event(type: "birthday", date: NSNumber(value: 12345), name: "День Рождения", handler: "Евгений Панкратов", address: nil)
        
        let holidaySteelMaker = Event(type: "holiday", date: NSNumber(value: 12345), name: "День Сталевара", handler: "ПОЛЕМА", address: nil)
        
        let holidayOpenFactory = Event(type: "holiday", date: NSNumber(value: 12345), name: "Открытие завода", handler: "ПОЛЕМА", address: nil)
        
        let birthdayIvankov = Event(type: "birthday", date: NSNumber(value: 12345), name: "День рождения", handler: "ПОЛЕМА", address: nil)
        
        
        return [jubileePolema,
                birthdayPankratov,
                holidaySteelMaker,
                holidayOpenFactory,
                birthdayIvankov]
    }
}
