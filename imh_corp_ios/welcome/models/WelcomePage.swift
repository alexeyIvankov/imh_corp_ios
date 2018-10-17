//
//  WelcomePage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class WelcomePage : IWelcomePage{
    
    var image:UIImage?
    var name:String
    var details:String
    
    required init(image:UIImage?,
                  name:String, 
                  details:String){
        self.image = image
        self.name = name
        self.details = details
    }
}
