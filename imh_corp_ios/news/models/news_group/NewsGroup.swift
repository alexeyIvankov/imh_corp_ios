//
//  NewsGroup.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class NewsGroup: Object, INewsGroup {
    
    @objc dynamic var name:String? = nil
    @objc dynamic var groupId:String? = nil
    @objc dynamic var descript:String? = nil
    
    var news = List<News>()
}
