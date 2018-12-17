//
//  LoginRouter.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class NewsRouter : INewsRouter{

    var owner:UIViewController?
    var loaderService:ILoaderService
    
    required init(loaderService:ILoaderService){
        self.loaderService = loaderService
    }
    
    func setOwnwer<T>(ownwer: T) where T : UIViewController {
        self.owner = ownwer
    }
    
    func handleSelect(news:INews){
        
        let newsDetailsController:NewsDetailsController = UIStoryboard.load(type: UIStoryboard.TypeSB.news).load()!
        newsDetailsController.news = news
        self.owner?.navigationController?.pushViewController(newsDetailsController, animated: true)
    }
    
    func handleTouchFilterButton(){
        let navigationControllerFilter:UINavigationController = UIStoryboard.load(type: UIStoryboard.TypeSB.news).load(id:"NavigationListGroupsNewsController")!
        self.owner?.navigationController?.present(navigationControllerFilter, animated: true, completion: nil)
    }

    func showLoader(){
       self.loaderService.showIfNeed()
    }
    
    func hideLoader(){
        self.loaderService.hideIfNeed()
    }
}
