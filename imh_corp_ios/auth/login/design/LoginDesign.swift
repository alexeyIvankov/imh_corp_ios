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
        
        loginVC.buttonLogin.backgroundColor = UIColor(r:112, g:178, b:250, alpha:1)
        
        loginVC.buttonLogin.setTitle("Далее", for: UIControl.State.normal)
        loginVC.buttonLogin.setTitle("Далее", for: UIControl.State.selected)
        
        loginVC.buttonLogin.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginVC.buttonLogin.setTitleColor(UIColor.white, for: UIControl.State.selected)
        
        loginVC.buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        
        loginVC.labelTitleLogin.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        loginVC.labelCountryName.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        
        loginVC.textFieldLogin.textColor = UIColor.black
        loginVC.textFieldCountryCode.textColor = UIColor.black
        
        loginVC.textFieldLogin.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        loginVC.textFieldCountryCode.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        

        let attributesPlaceholderTextField = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        ]
        
        loginVC.textFieldLogin.attributedPlaceholder =  NSAttributedString(string: "(999) 123 45 67", attributes:attributesPlaceholderTextField)
    }
    
}
