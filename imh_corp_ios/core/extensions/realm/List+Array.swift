//
//  List+Array.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

extension List{
    
    func convertToArray() -> [List.Element] {
        var array = [List.Element]()
        
        for obj in self{
            array.append(obj)
        }
        return array
    }
}
