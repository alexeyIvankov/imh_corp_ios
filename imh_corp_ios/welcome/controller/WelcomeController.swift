//
//  WelcomeController.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class WelcomeController : UIViewController{
    
    //MARK: Dependence
    var welcomeCake:IWelcomeCake = Depednence.tryInject()!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeCake.router.setOwnwer(ownwer: self)
        self.welcomeCake.design.apply(vc: self)
    }
}
