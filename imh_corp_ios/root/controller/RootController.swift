//
//  ViewController.swift
//  IMH BI
//
//  Created by Alexey Ivankov on 21.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import UIKit

class RootController: UITabBarController{

    //MARK:Status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Dependence
    var rootCake:IRootCake = Depednence.tryInject()!

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.rootCake.router.setOwnwer(ownwer: self)
        self.rootCake.design.apply(vc: self)
        self.showPMHLoaderIfAuth()
    }
    
    private func showPMHLoaderIfAuth(){
        
        if self.rootCake.director.authCake.authDirector.isAuth(){
            self.rootCake.router.showPMHLoader()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.rootCake.router.hidePMHLoader()
            }
        }
    }
}


