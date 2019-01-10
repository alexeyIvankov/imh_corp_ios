//
//  CompanyService.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 10/01/2019.
//  Copyright © 2019 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class EmployeeRequest : IEmployeeRequest{
    
    var name: String
    
    required init(name:String){
        self.name = name
    }
}
