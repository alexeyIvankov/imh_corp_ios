//
//  LoginRouter.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter : ILoginRouter{

    var owner:UIViewController?
    var loaderService:ILoaderService
    
    required init(loaderService:ILoaderService){
        self.loaderService = loaderService
    }
    
    func setOwnwer<T>(ownwer: T) where T : UIViewController {
        self.owner = ownwer
    }
    
    func handleTouchNextButton(phone:String, codeRegion:String){
        
        let confirmationController:ConfirmationController = UIStoryboard.load(type: UIStoryboard.TypeSB.auth).load()!
        confirmationController.phone = phone
        confirmationController.codeRegion = codeRegion
        self.owner?.navigationController?.pushViewController(confirmationController, animated: true)
    }
        
    func showLoader(){
       self.loaderService.showIfNeed()
    }
    
    func hideLoader(){
        self.loaderService.hideIfNeed()
    }

}
