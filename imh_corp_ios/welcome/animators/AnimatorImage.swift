//
//  AnimatorChangePageIcons.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 18.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class AnimatorImage : IAnimatorImage{

    let timerAnimate:ITimer
    var originImage:UIImage?
    var percentTransparentImage:Int32
    let percentStepTransparentImage:Int32
    let countFramesAnimation:Int
    let lifeTimeAnimtionFrame:TimeInterval
    
    required init (countFrames:Int,
                   lifeTimeAnimtionFrame:TimeInterval){
        
        self.timerAnimate = BackgroundTimer()
        self.countFramesAnimation = countFrames
        self.lifeTimeAnimtionFrame = lifeTimeAnimtionFrame
        self.percentStepTransparentImage = Int32(abs(100/countFrames))
        self.percentTransparentImage = 0
    }
    
    func prepareToStart() {
        self.percentTransparentImage = 0
        self.timerAnimate.stop()
        self.originImage = nil
    }
    
    func start(image:UIImage, frameAmimation:@escaping (UIImage?)->(), completion: (() -> ())?) {
        
        self.originImage = image
        
        self.timerAnimate.startNewAndStopOld(timeInterval: self.lifeTimeAnimtionFrame, countRepeats: self.countFramesAnimation, block: {_ in 
            
            DispatchQueue.global().async {
                self.percentTransparentImage += self.percentStepTransparentImage
                let image = self.originImage?.makeTransparent(self.percentTransparentImage)
                
                DispatchQueue.main.async {
                    frameAmimation(image)
                }
            }
        })
        {
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
}
