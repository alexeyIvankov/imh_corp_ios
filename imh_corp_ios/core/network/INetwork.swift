//
//  INetwork.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 23.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol INetwork : AnyObject {
    
    var hostUrl:String { get }
    var startPageUrl:String { get }
}
