//
//  IAPIDirector.swift
//  imh_corp_ios_api
//
//  Created by Alexey Ivankov on 25/10/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

public protocol IAPIDirector : AnyObject{
   
    var serverUrl:String { get }
    
    //MARK: Modules
    var authModule:IAuthModule { get }
}
