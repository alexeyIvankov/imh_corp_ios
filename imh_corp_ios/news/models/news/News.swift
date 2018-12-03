//
//  News.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 30/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class News : INews{
    
    var newsId: String!
    var body: String!
    var dateCreated: String!
    var limonadeId: String!
    var limonadeSortKey: String!
    var hashLimonade:Int
    
    var group:INewsGroup!
    var files:[IFile] = []
    
    static func createNews(news:[INews]) -> [INews]{
        
        var container = [INews]()
        
        for item in news{
            let currentNews = News(news: item)
            currentNews.group = NewsGroup(newsGroup: item.getGroup())
            currentNews.files = File.createFiles(files: item.getFiles())
            container.append(currentNews)
        }
        return container
    }
    
    static func createNew(new:INews) -> INews{
        let convertNews = News(news: new)
        convertNews.group = NewsGroup(newsGroup: new.getGroup())
        convertNews.files = File.createFiles(files: new.getFiles())
        return convertNews
    }
    
    required init(news:INews){
        
        self.newsId = news.newsId
        self.body = news.body
        self.dateCreated = news.dateCreated
        self.limonadeId = news.limonadeId
        self.limonadeSortKey = news.limonadeSortKey
        self.hashLimonade = news.getHashLimonade()
    }

    func getGroup() -> INewsGroup {
        return self.group
    }
    
    func getFiles() -> [IFile] {
        return self.files
    }
    
    func getHashLimonade() -> Int {
        return self.hashLimonade
    }
    
    func update(json: [String : Any]) {
        
    }
}
