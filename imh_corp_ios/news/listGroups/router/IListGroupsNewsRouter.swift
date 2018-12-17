//
//  INewsDetailsRouter.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

protocol IListGroupsNewsRouter : IRouter {
    func setOwnwer<T:UIViewController>(ownwer:T)
    
    func handleTouchDoneButton()
    
    func showLoader()
    func hideLoader()
}
