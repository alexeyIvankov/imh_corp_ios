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
    var session:ISession
    
    required init( network:INetwork,
                   dataStorage:INewsDataStorage,
                   session:ISession){
        
        self.network = network
        self.dataStorage = dataStorage
        self.session = session
    }
}
