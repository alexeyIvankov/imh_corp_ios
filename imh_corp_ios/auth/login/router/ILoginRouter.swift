//
//  ILoginRouter.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

protocol ILoginRouter : AnyObject {
    func setOwnwer<T:UIViewController>(ownwer:T)
    
    func handleTouchNextButton()
    
    func showAlert(message:String)
    func showLoader()
    func hideLoader()
}
