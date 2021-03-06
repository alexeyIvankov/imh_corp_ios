//
//  ILoginRouter.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

protocol INewsRouter : IRouter {
    func setOwnwer<T:UIViewController>(ownwer:T)
    
    func handleSelect(news:INews)
    func handleTouchFilterButton()
    
    func showLoader()
    func hideLoader()
}
