//
//  News.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class NewsRealm: Object, INews {
 
    @objc dynamic var newsId:String! = nil
    @objc dynamic var body:String! = nil
    @objc dynamic var dateCreated:String! = nil
    
    @objc dynamic var group:NewsGroupRealm!
    
    override static func primaryKey() -> String? {
        return "newsId"
    }
    
    var dateFormaterParser:DateFormatter {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy/MM/dd HH:mm:ss +zzzz"
        return formater
    }
    
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
    
    var files = List<FileRealm>()
    
    func getGroup() -> INewsGroup{
        return self.group
    }
    
    func getFiles() -> [IFile]{
        return self.files.convertToArray()
    }
    
    //MARK: IServerModel
    func update(json: [String : Any]) {
        
        let body:String? = json["body"] as? String
        let dateCreated = json["date_created"] as? String
        
        if body != nil{
            self.body = body
        }
        
        if dateCreated != nil,
            let date = self.dateFormaterParser.date(from: dateCreated!){
            self.dateCreated  = String(date.timeIntervalSince1970)
        }
    }
}
