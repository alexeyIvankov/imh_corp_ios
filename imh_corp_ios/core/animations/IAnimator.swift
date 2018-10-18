//
//  IAnimator.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 18.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IAnimator {
    func prepareToStart()
    func prepareToEnd()
    func start(completion:(()->())?)
    func stop(completion:(()->())?)
}

extension IAnimator{
    
    func start(completion: (() -> ())?) {}
    func stop(completion: (() -> ())?) {}
    func prepareToStart() {}
    func prepareToEnd() {}
    func start() {}
    func stop() {}
}
