//
//  AnimatorChangePageIcons.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 18.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class AnimatorHideImagePage : IAnimator{
  
    let animationView:UIView
    let chainableAnimator:ChainableAnimator
    
    required init (animationView:UIView){
        self.animationView = animationView
        self.chainableAnimator = ChainableAnimator(view: self.animationView)
    }
    
    func start(completion: (() -> ())?) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.animationView.alpha = 0
        }) { (success) in
            completion?()
        }
    }
}
