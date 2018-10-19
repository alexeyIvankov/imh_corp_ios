//
//  AnimatorShowImagePage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class AnimatorShowImagePage : IAnimator{
    
    let animationView:UIView
    let chainableAnimator:ChainableAnimator
    
    required init (animationView:UIView){
        self.animationView = animationView
        self.chainableAnimator = ChainableAnimator(view: self.animationView)
    }
    
    func start(completion: (() -> ())?) {
        
        self.animationView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.animationView.alpha = 1
        }) { (success) in
            completion?()
        }
    }
}
