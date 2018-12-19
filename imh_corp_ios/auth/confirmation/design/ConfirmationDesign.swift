//
//  LoginDesign.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 27.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class ConfirmationDesign : IConfirmationDesign {
    
    required init(appDesign: IAppDesign) {
        
    }
    
    func apply<T>(vc: T) where T : UIViewController {
        
        guard let confirmVC = vc as? ConfirmationController else {
            return
        }
        
        confirmVC.buttonSendCode.backgroundColor = UIColor(r:112, g:178, b:250, alpha:1)
        
        confirmVC.buttonSendCode.setTitle("Войти", for: UIControl.State.normal)
        confirmVC.buttonSendCode.setTitle("Войти", for: UIControl.State.selected)
        
        confirmVC.buttonSendCode.setTitleColor(UIColor.white, for: UIControl.State.normal)
        confirmVC.buttonSendCode.setTitleColor(UIColor.white, for: UIControl.State.selected)
        
        confirmVC.buttonSendCode.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        
        confirmVC.labelTitleConfirmation.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        confirmVC.labelTimeResendCode.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        
        confirmVC.textFieldConfirmation.textColor = UIColor.black
        
        confirmVC.textFieldConfirmation.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.regular)
    
        let attributesPlaceholderTextField = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        ]
        
        confirmVC.textFieldConfirmation.attributedPlaceholder =  NSAttributedString(string: "КОД ИЗ СМС", attributes:attributesPlaceholderTextField)
    }
    
}
