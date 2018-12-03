//
//  NewsGroup.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 30/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class NewsGroup : INewsGroup {
    
    private var news:[INews] = []
    private let hashLimonade:Int
    
    var limonadeId: String!
    var limonadeSortKey: String!
    var lastUpdateMessages:String!
    
    var name: String!
    var groupId: String!
    var descript: String!
    
    static func createGroups(groups:[INewsGroup]) -> [INewsGroup]{
        var container = [INewsGroup]()
        
        for item in groups{
            let group = NewsGroup(newsGroup: item)
            group.news = News.createNews(news: item.getNews())
            container.append(group)
        }
        return container
    }
    
    static func createGroup(group:INewsGroup) -> INewsGroup{
        let newGroup = NewsGroup(newsGroup: group)
        newGroup.news = News.createNews(news: group.getNews())
        return newGroup
    }
    
    required init(newsGroup:INewsGroup){
        self.name = newsGroup.name
        self.groupId = newsGroup.groupId
        self.descript = newsGroup.descript
        self.limonadeId = newsGroup.limonadeId
        self.limonadeSortKey = newsGroup.limonadeSortKey
        self.hashLimonade = newsGroup.getHashLimonade()
        self.lastUpdateMessages = newsGroup.lastUpdateMessages
    }
    
    func getNews() -> [INews] {
        return self.news
    }
    
    func getHashLimonade() -> Int {
        return self.hashLimonade
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
    
    func update(json: [String : Any]) {
        
    }
}
