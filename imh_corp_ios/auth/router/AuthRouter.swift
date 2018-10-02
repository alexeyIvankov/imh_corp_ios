//
//  AuthRouter.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class AuthRouter : IAuthRouter{
    
    func handleEventAppNotAuthorized(){
        
        let root:LoginController = UIStoryboard.load(type: UIStoryboard.TypeSB.auth).load()!
        _ = MyApplication.delegate()?.stackWindow.presentAndDismissAllExcept(vc: root)
    }
    
    func handleEventAppAuthorized(){
        
        let root:RootController = UIStoryboard.load(type: UIStoryboard.TypeSB.root).load()!
        _ = MyApplication.delegate()?.stackWindow.presentAndDismissAllExcept(vc: root)
    }
}
