//
//  PMHLoader.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 21/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class PMHLoader: IPMHLoader{

    required init(){
        
    }
    
    func show() {
        
        let pmhLoader = PMHLoaderVC(nibName: "PMHLoader", bundle: nil)
        let _ = MyApplication.delegate()?.stackWindow.presentToTop(vc: pmhLoader)
    }
    
    func hide() {
        MyApplication.delegate()?.stackWindow.tryDismiss(type: PMHLoaderVC.self)
    }
}

class PMHLoaderVC : UIViewController{

    @IBOutlet weak var imageViewPMHLogo:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startAnimationLogo(){
        
    }
}
