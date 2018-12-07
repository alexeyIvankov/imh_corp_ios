//
//  LoginDirector.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class NewsDirector : INewsDirector {

    var network:INetwork
    var dataStorage:INewsDataStorage
    var sessionService:ISessionService
    var serviceNews:IServiceNews
    
    required init( network:INetwork,
                   dataStorage:INewsDataStorage,
                   sessionService:ISessionService,
                   serviceNews:IServiceNews){
        
        self.network = network
        self.dataStorage = dataStorage
        self.sessionService = sessionService
        self.serviceNews = serviceNews
    }
}
