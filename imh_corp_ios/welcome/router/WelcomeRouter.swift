//
//  WelcomeRouter.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class WelcomeRouter : IWelcomeRouter {
    var owner: UIViewController?
    
    func setOwnwer(ownwer: UIViewController) {
        
        guard  let welcome = ownwer as? WelcomeController else {
            fatalError("failed type owner")
        }
        self.owner = welcome
    }
    
    func handleTouchNextButton(){
        
        let loginController:LoginController = UIStoryboard.load(type: UIStoryboard.TypeSB.auth).load()!
        self.owner?.navigationController?.pushViewController(loginController, animated: true)
    }
}
