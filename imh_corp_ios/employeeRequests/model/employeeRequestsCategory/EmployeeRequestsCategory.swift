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
    var type: EmployeeRequestCategoryType
    var services: [IEmployeeRequest]
    
    required init(name:String,
                  type:EmployeeRequestCategoryType,
                  services: [IEmployeeRequest]) {
        
        self.name = name
        self.type = type
        self.services = services
    }
}
