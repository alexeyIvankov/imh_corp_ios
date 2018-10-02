//
//  RootServiceLayer.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 23.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class RootServiceLayer : IRootServiceLayer {
   
    let securityService:ISecurityService
    
    required init(securityService:ISecurityService){
        self.securityService = securityService
    }
}