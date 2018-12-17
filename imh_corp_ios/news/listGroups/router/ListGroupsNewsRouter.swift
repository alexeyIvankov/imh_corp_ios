//
//  NewsDetailsRouter.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class ListGroupsNewsRouter : IListGroupsNewsRouter{
    
    var owner:UIViewController?
    var loaderService:ILoaderService
    
    required init(loaderService:ILoaderService){
        self.loaderService = loaderService
    }
    
    func setOwnwer<T>(ownwer: T) where T : UIViewController {
        self.owner = ownwer
    }
    
    func handleTouchDoneButton(){
        self.owner?.dismiss(animated: true, completion: nil)
    }
    
    func showLoader(){
        self.loaderService.showIfNeed()
    }
    
    func hideLoader(){
        self.loaderService.hideIfNeed()
    }
}
