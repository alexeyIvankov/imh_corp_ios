//
//  NewsGroupRealm.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class NewsGroupRealm: Object, INewsGroup {
   
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
    
    var news = List<NewsRealm>()
    
    func getNews() -> [INews]{
        return self.news.convertToArray()
    }
    
    //MARK: IServerModel
    func update(json: [String : Any]) {
        
        let group_id:Int? = json["id"] as? Int
        let name:String? = json["name"] as? String
        let descript = json["description"] as? String
        
        if group_id != nil{
             self.groupId = String(group_id!)
        }
       
        if name != nil{
            self.name = name
        }
        
        if self.descript != nil{
            self.descript = descript
        }
      
    }
}
