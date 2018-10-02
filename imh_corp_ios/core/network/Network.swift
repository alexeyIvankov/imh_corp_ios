//
//  Network.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 23.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class Network : INetwork {
        
    var startPageUrl: String {
        get{
            return self.hostUrl+":9502/analytics"
        }
    }
    
    var hostUrl: String

    required init(hostUrl:String){
        self.hostUrl = hostUrl
    }
}
