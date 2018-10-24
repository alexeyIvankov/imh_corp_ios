//
//  ITimer.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 22/10/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol ITimer : AnyObject{
    
    func startNewAndStopOld(timeInterval: TimeInterval,
                            countRepeats:Int,
                            block: @escaping(_ currentStep:Int)->(),
                            completion: @escaping()->())
    func stop()
}
