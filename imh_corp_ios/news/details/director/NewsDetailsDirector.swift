//
//  NewsDetailsDirector.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class NewsDetailsDirector: INewsDetailsDirector{
    
    var network:INetwork
    var dataStorage:INewsDataStorage
    var sessionService:ISessionService
    var fileDirector:IFileDirector
    
    required init( network:INetwork,
                   dataStorage:INewsDataStorage,
                   sessionService:ISessionService,
                   fileDirector:IFileDirector){
        
        self.network = network
        self.dataStorage = dataStorage
        self.sessionService = sessionService
        self.fileDirector = fileDirector
    }
}
