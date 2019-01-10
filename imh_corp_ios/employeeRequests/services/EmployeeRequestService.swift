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
        
        let salaryInfoCategory = EmployeeRequestsCategory(name: "Информация о заработной плате", type: "Информация о заработной плате", services: [])
        
        let employeeInfoCategory = EmployeeRequestsCategory(name: "Кадровая информация", type: "Кадровая информация", services: [])
        
        let requestsCategory = EmployeeRequestsCategory(name: "Запросы", type: "Запросы", services: [])
        
        let documentTemplateCategory = EmployeeRequestsCategory(name: "Шаблоны документов", type: "Шаблоны документов", services: [])
        
        let educationCategory = EmployeeRequestsCategory(name: "Аттестация и обучение", type: "Аттестация и обучение", services: [])
        
        
        return [salaryInfoCategory,
                employeeInfoCategory,
                requestsCategory,
                documentTemplateCategory,
                educationCategory]
    }
}
