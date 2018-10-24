//
//  UINavigationControllerTransparentBar.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 24/10/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class UINavigationControllerTransparentBar : UINavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.backgroundColor = UIColor.clear
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.top, barMetrics: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }
    
}
