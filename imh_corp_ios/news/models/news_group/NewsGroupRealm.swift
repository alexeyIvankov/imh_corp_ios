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
    @objc dynamic var lastUpdateMessages:String! = String(Date().timeIntervalSince1970)
    
    @objc dynamic var account:AccountRealm!
    
    override static func primaryKey() -> String? {
        return "groupId"
    }
    
    //MARK: ILimonadeItem 
    var limonadeId: String!{
        return String(self.groupId!)
    }
    
    var limonadeSortKey: String!{
        return String(self.name!)
    }
    
    func getHashLimonade() -> Int {
        return self.name.hashValue ^ self.descript.hashValue ^ self.news.count.hashValue
    }
    
    var news = List<NewsRealm>()
    
    func getNews() -> [INews]{
        return self.news.convertToArray()
    }
    
    func getLastMessageId() ->String?{
    
        var lastMessageId:String? = nil
        
        if self.getNews().count > 0{
            let sortedNews = self.getNews().sorted(by: { (new1, new2) -> Bool in
                if let dt1 = Double(new1.dateCreated),
                    let dt2 = Double(new2.dateCreated){
                    
                    if dt1 > dt2 {
                        return false
                    }
                    else {
                        return true
                    }
                }
                else {
                    return false
                }
            })
            lastMessageId = sortedNews.first!.newsId
        }
        return lastMessageId
    }
    
    //MARK: IServerModel
    func update(json: [String : Any]) {
        
        let name:String? = json["name"] as? String
        let descript = json["description"] as? String
       
        if name != nil{
            self.name = name
        }
        
        if self.descript != nil{
            self.descript = descript
        }
    }
}
