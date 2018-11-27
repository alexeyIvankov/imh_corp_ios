//
//  RootDesign.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class RootDesign : IRootDesign{
    
    private var rootVC:RootController!
    
    required init(appDesign: IAppDesign) {
        
    }
    
    func apply<T>(vc: T) where T : UIViewController {
        
        guard let rootVC = vc as? RootController else {
            return
        }
        self.rootVC = rootVC
        self.configureTabBar()
    }
    
    private func configureTabBar(){
        
        for (_,vc) in self.rootVC!.viewControllers!.enumerated(){
            if let navigationVC:UINavigationController = vc as? UINavigationController{
                for (_,currentVC) in navigationVC.viewControllers.enumerated(){
                    
                    if currentVC is NewsController{
                        currentVC.tabBarItem.image =  UIImage(named: "news_icon_deselect")?.withRenderingMode(.alwaysOriginal)
                        currentVC.tabBarItem.selectedImage = UIImage(named: "news_icon_select")?.withRenderingMode(.alwaysOriginal)
                    }
                    else if currentVC is EventsController{
                        currentVC.tabBarItem.image =  UIImage(named: "events_icon_deselect")?.withRenderingMode(.alwaysOriginal)
                        currentVC.tabBarItem.selectedImage = UIImage(named: "events_icon_select")?.withRenderingMode(.alwaysOriginal)
                    }
                    else if currentVC is СompanyServicesController{
                        currentVC.tabBarItem.image =  UIImage(named: "hand_icon_deselect")?.withRenderingMode(.alwaysOriginal)
                        currentVC.tabBarItem.selectedImage = UIImage(named: "hand_icon_select")?.withRenderingMode(.alwaysOriginal)
                    }
                    else if currentVC is MoreController{
                        currentVC.tabBarItem.image =  UIImage(named: "people_icon_deselect")?.withRenderingMode(.alwaysOriginal)
                        currentVC.tabBarItem.selectedImage = UIImage(named: "people_icon_select")?.withRenderingMode(.alwaysOriginal)
                    }
                }
            }
        }
    }
}
