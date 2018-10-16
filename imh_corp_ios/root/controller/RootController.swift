//
//  ViewController.swift
//  IMH BI
//
//  Created by Alexey Ivankov on 21.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import UIKit
import WebKit

class RootController: UIViewController , WKNavigationDelegate, ISessionServiceDelegate{

    
    //MARK:Status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Dependence
    var rootCake:IRootCake = Depednence.tryInject()!
    var authService:IAuthDirector = Depednence.tryInject()!

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.rootCake.router.setOwnwer(ownwer: self)
    }
    
    //MARK: - SessionServiceDelegate
    func sessionExpired() {
    }

}


