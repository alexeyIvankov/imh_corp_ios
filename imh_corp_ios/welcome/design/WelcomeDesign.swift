//
//  WelcomeDesign.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class WelcomeDesign : IWelcomeDesign {
    
    required init(appDesign: IAppDesign) {
        
    }
    
    func apply<T>(vc: T) where T : UIViewController {
        
        guard let welcomeVC = vc as? WelcomeController else {
            return
        }
        
        welcomeVC.pageControll?.configureToWelcomeScreen()
        welcomeVC.buttonStart.backgroundColor = UIColor(r:112, g:178, b:250, alpha:1)
        welcomeVC.buttonStart.layer.cornerRadius = 25
        
        welcomeVC.buttonStart.setTitle("Далее", for: UIControl.State.normal)
        welcomeVC.buttonStart.setTitle("Далее", for: UIControl.State.selected)
        
        welcomeVC.buttonStart.setTitleColor(UIColor.white, for: UIControl.State.normal)
        welcomeVC.buttonStart.setTitleColor(UIColor.white, for: UIControl.State.selected)
        
        welcomeVC.buttonStart.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
    }
    
    func apply(cell:WelcomePagerCell){
        cell.labelNamePage.textColor = UIColor.black
        cell.labelDescriptionPage.textColor = UIColor.black
        
        cell.labelNamePage.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.light)
        cell.labelDescriptionPage.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
    }
}

extension FSPageControl{
    func configureToWelcomeScreen(){
        self.itemSpacing = 7
        self.interitemSpacing = 10
        self.contentHorizontalAlignment = .center
        self.contentInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        self.hidesForSinglePage = true
        self.setFillColor(UIColor(r:207, g:206, b:207, alpha:1), for: UIControl.State.normal)
        self.setFillColor(UIColor(r:112, g:178, b:250, alpha:1), for: UIControl.State.selected)
    }
}
