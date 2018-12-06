//
//  ILimonadeItem.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 26/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol ILimonadeItem : AnyObject {
    var limonadeId:String! { get }
    var limonadeSortKey:String! { get }
    var model:Any? { get }
    
    func getHashLimonade() -> Int
}
