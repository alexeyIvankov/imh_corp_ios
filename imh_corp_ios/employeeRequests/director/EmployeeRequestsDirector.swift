//
//  LoginDirector.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class EmployeeRequestsDirector : IEmployeeRequestsDirector {

    let serviceEmployeeRequests:IEmployeeRequestService
    
    required init(serviceEmployeeRequests:IEmployeeRequestService) {
        self.serviceEmployeeRequests = serviceEmployeeRequests
    }
    
    func getFakeCategories() -> [IEmployeeRequestCategory] {
        return self.serviceEmployeeRequests.getCategories()
    }
  
}
