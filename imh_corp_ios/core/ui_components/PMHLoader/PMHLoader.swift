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

    @IBOutlet weak var imageViewPMH:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startAnimationRotate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startAnimationRotate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.stopAnimationRotate()
    }
    
    func startAnimationRotate(){
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi
        rotationAnimation.repeatCount = Float.infinity
        rotationAnimation.duration = 2.0
        self.imageViewPMH.layer.add(rotationAnimation, forKey: nil)
    }
    
    func stopAnimationRotate(){
        self.imageViewPMH.layer.removeAllAnimations()
    }
}
