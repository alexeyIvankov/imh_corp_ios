//
//  IAuthServices.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 22.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IAuthDirector : AnyObject {
 
    var sessionService:ISessionService { get set}
    
    func isAuth() -> Bool
}
