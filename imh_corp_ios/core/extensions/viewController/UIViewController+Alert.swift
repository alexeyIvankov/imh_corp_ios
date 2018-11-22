//
//  UIViewController+Alert.swift
//  
//
//  Created by Alexey Ivankov on 22/11/2018.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showAlertInfo(message:String, title:String="", handlerActionClose: (()->())? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction( UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (action) in
            handlerActionClose?()
        })
       
        self.present(alert, animated: true, completion: nil)
    }
}
