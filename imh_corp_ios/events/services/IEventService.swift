//
//  IEventServices.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 10/01/2019.
//  Copyright © 2019 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol IEventService : AnyObject{
    func getFakeAllEvents() -> [IEvent]
    func getFakeEventsToday() -> [IEvent]
}
