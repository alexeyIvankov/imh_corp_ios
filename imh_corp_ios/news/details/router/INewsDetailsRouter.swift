//
//  INewsDetailsRouter.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

protocol INewsDetailsRouter : IRouter {
    func setOwnwer<T:UIViewController>(ownwer:T)
    func handleTapToSliderImage()
    
    func showLoader()
    func hideLoader()
}
