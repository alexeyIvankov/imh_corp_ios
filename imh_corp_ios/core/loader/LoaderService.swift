//
//  LoaderService.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 27.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class LoaderService : ILoaderService {
    
    var loader:FullSreenLoader? = nil
    
    func isActive() -> Bool{
        if self.loader != nil {
            return true
        }
        else {
            return false
        }
    }
    
    func showIfNeed(){
        
        guard isActive() == false else {
            return
        }
        
        self.loader = FullSreenLoader(nibName: "FullSreenLoader", bundle: nil)
        let w = MyApplication.application().appDelegate?.stackWindow.presentToTop(vc: self.loader!)
        w?.backgroundColor = UIColor.clear
    }
    
    func hideIfNeed(){
    
        guard isActive() == true else {
            return
        }
        
        self.loader?.view.removeFromSuperview()
        self.loader = nil
         _ = MyApplication.application().appDelegate?.stackWindow.tryDismissTop()
    }
}
