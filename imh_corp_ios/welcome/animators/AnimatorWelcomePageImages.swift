//
//  AnimatorChangePageIcons.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 18.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class AnimatorWelcomePageImages : IAnimator{
  
    let viewIcon:UIView
    let chainableAnimator:ChainableAnimator
    
    required init (viewIcon:UIView){
        self.viewIcon = viewIcon
        self.chainableAnimator = ChainableAnimator(view: self.viewIcon)
    }
    
    func start(completion: (() -> ())?) {
        
//        let animation = self.chainableAnimator.transform(scale: 2).easeOutQuint.wait(t: 2.0)
//
//        if completion != nil{
//             animation.completion = completion!
//        }
//        animation.animate(t: 0.5)
        completion?()
    }
}
