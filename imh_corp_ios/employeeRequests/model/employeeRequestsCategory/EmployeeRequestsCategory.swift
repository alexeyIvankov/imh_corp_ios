//
//  CompanyServiceCategory.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 10/01/2019.
//  Copyright © 2019 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class EmployeeRequestsCategory : IEmployeeRequestCategory{
    
    var name: String
    var type: String
    var services: [IEmployeeRequest]
    
    required init(name:String,
                  type:String,
                  services: [IEmployeeRequest]) {
        
        self.name = name
        self.type = type
        self.services = services
    }
}
