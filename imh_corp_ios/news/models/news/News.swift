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
    var files:[IFile]
    
    static func createNews(news:[INews]) -> [INews]{
        
        var container = [INews]()
        
        for item in news{
            container.append(News(news: item))
        }
        return container
    }
    
    required init(news:INews){
        
        self.newsId = news.newsId
        self.body = news.body
        self.dateCreated = news.dateCreated
        self.limonadeId = news.limonadeId
        self.limonadeSortKey = news.limonadeSortKey
        //self.group = group
        self.files = File.createFiles(files: news.getFiles())
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
