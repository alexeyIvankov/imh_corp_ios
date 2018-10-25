//
//  IAuthServices.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 22.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IAuthDirector : AnyObject {

    func isAuth() -> Bool
    
    func authorization(countryCode:String,
                       phone:String,
                       success:@escaping (IAccount)->(),
                       error:@escaping (IError)->())
}
