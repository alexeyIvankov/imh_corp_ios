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
    var accountId: String!
    var groupId:String!
    var body: String!
    var groupName:String!
    var dateCreated: Int
    var containsImages: Bool = false
    
    var attaches: [IFile] = []
    
    static func createNews(news:[INews]) -> [INews]{
        
        var container = [INews]()
        
        for item in news{
            let currentNews = News.createNew(new: item)
            container.append(currentNews)
        }
        return container
    }
    
    static func createNew(new:INews) -> INews{
        let convertNews = News(news: new)
        convertNews.attaches = File.createFiles(files: new.attaches)
        return convertNews
    }
    
    required init(news:INews){
        
        self.newsId = news.newsId
        self.accountId = news.accountId
        self.body = news.body
        self.dateCreated = news.dateCreated
        self.groupId = news.groupId
        self.groupName = news.groupName
        self.containsImages = news.containsImages
    }

}
