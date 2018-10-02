//
//  LoginDesign.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 27.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class LoginDesign : ILoginDesign {
    
    required init(appDesign: IAppDesign) {
        
    }
    
    func apply<T>(vc: T) where T : UIViewController {
        
        guard let loginVC = vc as? LoginController else {
            return
        }
        
        loginVC.textFieldLogin.textColor =  UIColor(r: 0, g: 77, b: 127)
        loginVC.textFieldPassword.textColor = UIColor(r: 0, g: 77, b: 127)
        loginVC.textFieldLogin.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        loginVC.textFieldPassword.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        
        let attributesPlaceholderTextField = [
            NSAttributedString.Key.foregroundColor: UIColor(r: 197, g: 197, b: 197),
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        ]
        
        loginVC.textFieldLogin.attributedPlaceholder =  NSAttributedString(string: "Логин", attributes:attributesPlaceholderTextField)
        loginVC.textFieldPassword.attributedPlaceholder =  NSAttributedString(string: "Пароль", attributes:attributesPlaceholderTextField)
    }
    
}
