//
//  IRouter.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 30.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

protocol IRouter : AnyObject {
    
    var owner:UIViewController? { get}
    
    func setOwnwer(ownwer:UIViewController)
}

extension IRouter{
    func showAlertInfo(message:String, title:String="", handlerActionClose: (()->())? = nil){
        self.owner?.showAlertInfo(message: message, title: title, handlerActionClose: handlerActionClose)
    }
}
