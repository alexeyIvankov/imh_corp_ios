//
//  LimonadeItemTemplate.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 29/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class LimonadeItemTemplate: ILimonadeItem{
    
    let hashLimonage:Int
    var limonadeId: String!
    var limonadeSortKey: String!
    var model:Any?
    
    init(limonadeId:String,
         limonadeSortKey:String,
         hashLimonage:Int,
         model:Any?=nil){
        
        self.limonadeId = limonadeId
        self.limonadeSortKey = limonadeSortKey
        self.hashLimonage = hashLimonage
        self.model = model
    }
    
    func getHashLimonade() -> Int {
        return self.hashLimonage
    }
}
