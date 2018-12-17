//
//  INewsDetailsCake.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IListGroupsNewsCake : AnyObject {
    
    var router:IListGroupsNewsRouter { get }
    var director:IListGroupsNewsDirector { get }
    var design:IListGroupsNewsDesign { get }
}
