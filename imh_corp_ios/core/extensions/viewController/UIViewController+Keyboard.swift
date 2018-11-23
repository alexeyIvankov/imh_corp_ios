//
//  UIViewController+Keyboard.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 23/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func hideKeyboard(){
        self.view.endEditing(true)
    }
}
