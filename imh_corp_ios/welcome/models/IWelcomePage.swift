//
//  IWelcomePage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

protocol IWelcomePage : AnyObject{
    
    var image:UIImage? { get }
    var name:String { get }
    var details:String { get }
}
