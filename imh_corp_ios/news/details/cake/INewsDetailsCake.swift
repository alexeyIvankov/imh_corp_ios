//
//  INewsDetailsCake.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol INewsDetailsCake : AnyObject {
    
    var router:INewsDetailsRouter { get }
    var director:INewsDetailsDirector { get }
    var design:INewsDetailsDesign { get }
}
