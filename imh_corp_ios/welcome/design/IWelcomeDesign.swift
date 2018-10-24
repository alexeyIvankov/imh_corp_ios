//
//  IWelcomeDesign.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

protocol IWelcomeDesign : AnyObject, IDesign {
    func apply(cell:WelcomePagerCell)
}
