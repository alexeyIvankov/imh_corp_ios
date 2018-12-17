//
//  NewsDetailsDirector.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class ListGroupsNewsDirector: IListGroupsNewsDirector{
    
    var network:INetwork
    var dataStorage:INewsDataStorage
    var sessionService:ISessionService
    var serviceGroups:IServiceGroups
    
    required init( network:INetwork,
                   dataStorage:INewsDataStorage,
                   sessionService:ISessionService,
                   serviceGroups:IServiceGroups){
        
        self.network = network
        self.dataStorage = dataStorage
        self.sessionService = sessionService
        self.serviceGroups = serviceGroups
    }
}
