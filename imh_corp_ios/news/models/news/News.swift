//
//  News.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class News: Object, INews {
 
    @objc dynamic var newsId:String! = nil
    @objc dynamic var body:String! = nil
    @objc dynamic var dateCreated:String! = nil
    let groups = LinkingObjects(fromType: NewsGroup.self, property: "news")
    
    //MARK: ILimonadeItem
    var limonadeId: String!{
        return String(self.newsId!)
    }
    
    var limonadeSortKey: String!{
        return String(self.dateCreated!)
    }
    
    func getHashLimonade() -> Int {
        return self.body.hashValue ^ self.dateCreated.hashValue
    }
    
    var files = List<File>()
    
    func getGroup() -> INewsGroup{
        return self.groups.first!
    }
    
    func getFiles() -> [IFile]{
        return self.files.toArray()
    }
    
    //MARK: IServerModel
    func update(json: [String : Any]) {
        
        let newsId:Int? = json["id"] as? Int
        let body:String? = json["body"] as? String
        let dateCreated = json["date_created"] as? String
        
        if newsId != nil{
            self.newsId = String(newsId!)
        }
       
        if body != nil{
            self.body = body
        }
        
        if dateCreated != nil{
            self.dateCreated  = dateCreated
        }
        
    }
}
