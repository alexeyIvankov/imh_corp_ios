//
//  NewsGroup.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 30/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class NewsGroup : INewsGroup {
    
    private let news:[INews]
    private let hashLimonade:Int
    
    var limonadeId: String!
    var limonadeSortKey: String!
    
    var name: String!
    var groupId: String!
    var descript: String!
    
    static func createGroups(groups:[INewsGroup]) -> [INewsGroup]{
        var container = [INewsGroup]()
        
        for item in groups{
            container.append(NewsGroup(newsGroup: item))
        }
        return container
    }
    
    required init(newsGroup:INewsGroup){
        self.name = newsGroup.name
        self.groupId = newsGroup.groupId
        self.descript = newsGroup.descript
        self.limonadeId = newsGroup.limonadeId
        self.limonadeSortKey = newsGroup.limonadeSortKey
        self.news = News.createNews(news:newsGroup.getNews())
        self.hashLimonade = newsGroup.getHashLimonade()
    }
    
    func getNews() -> [INews] {
        return self.news
    }
    
    func getHashLimonade() -> Int {
        return self.hashLimonade
    }
    
    func update(json: [String : Any]) {
        
    }
}
