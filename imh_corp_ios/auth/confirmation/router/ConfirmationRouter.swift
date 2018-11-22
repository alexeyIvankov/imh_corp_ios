//
//  LoginRouter.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class ConfirmationRouter : IConfirmationRouter{

    var owner:UIViewController?
    var loaderService:ILoaderService
    
    required init(loaderService:ILoaderService){
        self.loaderService = loaderService
    }
    
    func setOwnwer<T>(ownwer: T) where T : UIViewController {
        self.owner = ownwer
    }
    
    
    func hadleEventLoginSuccess(){
       
        let root:RootController = UIStoryboard.load(type: UIStoryboard.TypeSB.root).load()!
        _ = MyApplication.delegate()?.stackWindow.presentAndDismissAllExcept(vc: root)
    }
    
    func showLoader(){
       self.loaderService.showIfNeed()
    }
    
    func hideLoader(){
        self.loaderService.hideIfNeed()
    }

}
