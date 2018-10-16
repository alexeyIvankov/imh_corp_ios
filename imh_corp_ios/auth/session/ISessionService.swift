//
//  ISessionService.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.09.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol ISessionServiceDelegate : AnyObject{
    func sessionExpired()
}

public protocol ISessionService {
    
    var delegate:ISessionServiceDelegate? { get set }
}
