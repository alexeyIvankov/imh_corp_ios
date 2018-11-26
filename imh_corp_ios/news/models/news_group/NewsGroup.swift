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
  
    @objc dynamic var name:String! = nil
    @objc dynamic var groupId:String! = nil
    @objc dynamic var descript:String! = nil
    
    //MARK: ILimonadeItem 
    var limonadeId: String!{
        return String(self.groupId!)
    }
    
    var limonadeSortKey: String!{
        return String(self.name!)
    }
    
    func getHashLimonade() -> Int {
        return self.name.hashValue ^ self.descript.hashValue
    }
    
    var news = List<News>()
    
    func getNews() -> [INews]{
        return self.news.toArray()
    }
}
