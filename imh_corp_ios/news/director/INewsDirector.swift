//
//  ILoginDirector.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol INewsDirector : AnyObject {
    
    var serviceNews:IServiceNews { get }
    var serviceGroups:IServiceGroups { get }
    var fileDirector:IFileDirector { get }
    
}
