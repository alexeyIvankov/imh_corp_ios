//
//  EmployeeRequestService.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 10/01/2019.
//  Copyright © 2019 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class EmployeeRequestService : IEmployeeRequestService{
 
    func getCategories() -> [IEmployeeRequestCategory]{
        
        let salaryInfoCategory = EmployeeRequestsCategory(name: "Информация о заработной плате", type: EmployeeRequestCategoryType.salaryInformation, services: [])
        
        let employeeInfoCategory = EmployeeRequestsCategory(name: "Кадровая информация", type: EmployeeRequestCategoryType.personnelInformation, services: [])
        
        let requestsCategory = EmployeeRequestsCategory(name: "Запросы", type: EmployeeRequestCategoryType.requests, services: [])
        
        let documentTemplateCategory = EmployeeRequestsCategory(name: "Шаблоны документов", type: EmployeeRequestCategoryType.templates, services: [])
        
        let educationCategory = EmployeeRequestsCategory(name: "Аттестация и обучение", type: EmployeeRequestCategoryType.education, services: [])
        
        
        return [salaryInfoCategory,
                employeeInfoCategory,
                requestsCategory,
                documentTemplateCategory,
                educationCategory]
    }
}
