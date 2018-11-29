//
//  LimonadeItemTemplate.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 29/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class LimonadeItemTemplate: ILimonadeItem{
    
    let value:String
    
    init(value:String){
        self.value = value
    }
    
    var limonadeId: String!{
        return self.value
    }
    
    var limonadeSortKey: String!{
        return self.value
    }
    
    func getHashLimonade() -> Int {
        return self.value.hashValue
    }
}
