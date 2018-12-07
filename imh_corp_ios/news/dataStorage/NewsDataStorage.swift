//
//  NewsDataStorage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 23/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class NewsDataStorage : INewsDataStorage{

    private let db:IDataBase
    
    required init(db:IDataBase) {
        self.db = db
    }
    
    
    func createOrUpdateNews(accountId:String,
                            newsJson:[Any],
                            completion:@escaping ()->()){
        
        let groupDbOperations = DispatchGroup()
        
        for item in newsJson{
            
            if let newsDict:[String:Any] = item as? [String:Any],
                let newsId:Int = newsDict["id"] as? Int,
                let body = newsDict["body"] as? String,
                let groupDict:[String:Any] = newsDict["group"] as? [String:Any],
                let groupId:Int = groupDict["id"] as? Int,
                let groupName = groupDict["name"] as? String,
                let dateCreatedNews = newsDict["date_created"] as? Int{
                
                var attachesImages = [Any]()
                var attachesFiles = [Any]()
                var attachesAll = [Any]()
                groupDbOperations.enter()
                
                if let attaches = newsDict["attaches"] as? [String:Any]{
                    
                    if let imagesDict = attaches["images"] as? [[String:Any]]{
                        
                        for curentImageDict in imagesDict{
                            if let _ = curentImageDict["id"] as? String,
                                let _ = curentImageDict["type"] as? String,
                                let _ = curentImageDict["content_type"] as? String{
                                attachesImages.append(curentImageDict)
                            }
                        }
                    }
                    
                    if let filesDict = attaches["files"] as? [[String:Any]]{
                        
                        for currentFileDict in filesDict{
                            if let _ = currentFileDict["id"] as? String,
                                let _ = currentFileDict["type"] as? String,
                                let _ = currentFileDict["content_type"] as? String{
                                attachesFiles.append(currentFileDict)
                            }
                        }
                    }
                }
                attachesAll = attachesFiles + attachesImages
               
                
                let newsIdStr = String(newsId)
                let groupIdStr = String(groupId)
                
            
                self.db.asynchFetch(type: NewsRealm.self,
                                    options: FetchOptionsPredicate(predicate:  NSPredicate(format: "newsId='\(newsIdStr)' AND accountId='\(accountId)'"), sortBy: nil), completion: { (res, ctx) in
                                       let newsDb = res.first
                                        
                                        if newsDb == nil{
                                            
                                            self.db.asynchWrite(context:ctx,
                                                                transaction: { () -> ([NewsRealm]) in
                                                
                                                let newsDb = NewsRealm()
                                                newsDb.newsId = newsIdStr
                                                newsDb.groupName = groupName
                                                newsDb.groupId = groupIdStr
                                                newsDb.accountId = accountId
                                                newsDb.dateCreated = dateCreatedNews
                                                newsDb.body = body
                                                
                                                return [newsDb]
                                                
                                            }, completion: { (_) in
                                                groupDbOperations.leave()
                                            })
                                            
                                        }
                                        else {
                                            if newsDb!.body.hashValue != body.hashValue{
                                                
                                                self.db.asynchUpdate(context: ctx, block: {
                                                    newsDb!.body = body
                                                    
                                                }, completion: { (ctx) in
                                                    groupDbOperations.leave()
                                                })
                                            }
                                            else{
                                                groupDbOperations.leave()
                                            }
                                        }
                })
            }
        }
        
        groupDbOperations.notify(queue: .main) {
            completion()
        }
    }
    
    func getNews(accountId:String,
                 startDate:Int,
                 count:Int,
                 completion:@escaping ([INews])->()){
        
        
        self.db.asynchFetch(type: NewsRealm.self, options: FetchOptionsPredicate(predicate:  NSPredicate(format: "accountId='\(accountId)' AND dateCreated > \(startDate)"), sortBy: ("dateCreated", true))) { (res, ctx)  in
            
            if res.count <= count{
                completion(News.createNews(news: res))
            }
            else {
                completion(News.createNews(news: Array(res[0..<count])))
            }
        }
    }
    
    func getNews(accountId:String,
                 startDate:Int?,
                 endDate:Int?,
                 count:Int,
                 completion:@escaping ([INews])->()){
        
        let predicate:NSPredicate?
        
        if startDate != nil && endDate != nil{
            predicate = NSPredicate(format: "accountId='\(accountId)' AND dateCreated > \(startDate!) AND dateCreated < \(endDate!)")
        }
        else if startDate != nil{
            predicate = NSPredicate(format: "accountId='\(accountId)' AND dateCreated > \(startDate!)")
        }
        else if endDate != nil{
            predicate = NSPredicate(format: "accountId='\(accountId)' AND dateCreated < \(endDate!)")
        }
        else {
            predicate = NSPredicate(format: "accountId='\(accountId)'")
        }
        
        self.db.asynchFetch(type: NewsRealm.self, options: FetchOptionsPredicate(predicate: predicate!, sortBy: ("dateCreated", true))) { (res, ctx)  in
            
            if res.count <= count{
                completion(News.createNews(news: res))
            }
            else {
                completion(News.createNews(news: Array(res[0..<count])))
            }
        }
    }
}
