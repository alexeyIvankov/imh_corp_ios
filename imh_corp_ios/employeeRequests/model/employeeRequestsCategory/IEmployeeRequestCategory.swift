//
//  ICompanyServiceCategory.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 10/01/2019.
//  Copyright © 2019 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol IEmployeeRequestCategory{
    
    var name:String { get }
    var type:String { get }
    var services:[IEmployeeRequest] { get }
}
