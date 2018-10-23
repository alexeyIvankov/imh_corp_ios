//
//  IAnimatorImage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 22/10/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IAnimatorImage : IAnimator{
    
    func start(image:UIImage,
               frameAmimation:@escaping (UIImage?)->(),
               completion: (() -> ())?)
}
