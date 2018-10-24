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
    
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        owner?.present(alert, animated: true, completion: nil)
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
