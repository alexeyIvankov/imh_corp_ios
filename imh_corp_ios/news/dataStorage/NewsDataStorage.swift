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
        groupDbOperations.enter()
        
        for item in newsJson{
            
            if let newsDict:[String:Any] = item as? [String:Any],
                let newsId:Int = newsDict["id"] as? Int,
                let body = newsDict["body"] as? String,
                let groupDict:[String:Any] = newsDict["group"] as? [String:Any],
                let groupId:Int = groupDict["id"] as? Int,
                let groupName = groupDict["name"] as? String,
                let dateCreatedNews = newsDict["date_created"] as? Int{
                
                let attachesAll = self.tryParseAttachFrom(json: newsDict)
                
                groupDbOperations.enter()
               
                
                let newsIdStr = String(newsId)
                let groupIdStr = String(groupId)
                
            
                self.db.asynchFetch(type: NewsRealm.self,
                                    options: FetchOptionsPredicate(predicate:
                                        NSPredicate(format: "newsId='\(newsIdStr)' AND accountId='\(accountId)'"), sortBy: nil),
                                    completion: { (resNews, ctx) in
                                      
                                        let newsDb = resNews.first
                                        
                                        if newsDb == nil{
                                            
                                            self.db
                                                .asynchWrite(context:ctx,
                                                             transaction: { () -> ([NewsRealm]) in
                                                                
                                                                let newsDb = ctx.createObj(type: NewsRealm.self, value:[newsIdStr,accountId, groupIdStr,groupName, body, dateCreatedNews], update: true)
                                                                
                                                                for item in attachesAll{
                                                                    
                                                                    if let attachDict = item as? [String:Any],
                                                                        let _ = attachDict["id"] as? Int,
                                                                        let _ = attachDict["type"] as? String,
                                                                        let _ = attachDict["content_type"] as? String{
                                                                        
                                                                        let values = self.convertAttachDictToValues(newsId: newsIdStr, attachDict: attachDict)
                                                                        
                                                                        let fileDb = ctx.createObj(type: FileRealm.self, value:values, update: true)
                                                                        
                                                                        newsDb.attachesDb.append(fileDb)
                                                                    }
                                                                }
                                                                
                                                                
                                                                return [newsDb]
                                                                
                                                }, completion: { (_) in
                                                    groupDbOperations.leave()
                                                })
                                        }
                                        else{
                                            groupDbOperations.leave()
                                        }
                })
            }
        }
        
        groupDbOperations.leave()
        groupDbOperations.notify(queue: .main) {
            completion()
        }
    }
    

    private func tryParseAttachFrom(json:[String:Any]) ->[Any]{
        
        var attachesImages = [Any]()
        var attachesFiles = [Any]()
        
        if let attaches = json["attaches"] as? [String:Any]{
            
            if let imagesDict = attaches["images"] as? [[String:Any]]{
                
                for curentImageDict in imagesDict{
                    if let _ = curentImageDict["id"] as? Int,
                        let _ = curentImageDict["type"] as? String,
                        let _ = curentImageDict["content_type"] as? String{
                        attachesImages.append(curentImageDict)
                    }
                }
            }
            
            if let filesDict = attaches["files"] as? [[String:Any]]{
                
                for currentFileDict in filesDict{
                    if let _ = currentFileDict["id"] as? Int,
                        let _ = currentFileDict["type"] as? String,
                        let _ = currentFileDict["content_type"] as? String{
                        attachesFiles.append(currentFileDict)
                    }
                }
            }
        }
  
        return attachesFiles + attachesImages
    }
    
    
    private func convertAttachDictToValues(newsId:String,
                                           attachDict:[String:Any]) ->[Any]{
        
        let attachId = attachDict["id"] as? Int
        let type = attachDict["type"] as? String
        let contentType = attachDict["content_type"] as? String
        
        let attachIdStr = String(attachId!)
        let name =  attachDict["name"] as? String
        let size = attachDict["size"] as? Int
        let contentClass = attachDict["content_class"] as? String
        let dateCreated =  attachDict["date_created"] as? String
        let largeIconUrl =  attachDict["large_icon_ur"] as? String
        let previewUrl =  attachDict["preview_ur"] as? String
        let smallIconUrl =  attachDict["small_icon_ur"] as? String
        let url =  attachDict["url"] as? String
        
        var values = [Any]()
        values.append(attachIdStr)
        values.append(newsId)
        
        if name != nil{
            values.append(name!)
        }
        
        values.append(type!)
        values.append(contentType!)
        
        if dateCreated != nil{
            values.append(dateCreated!)
        }
        
        if url != nil{
            values.append(url!)
        }
        
        if largeIconUrl != nil{
            values.append(largeIconUrl!)
        }
        
        if previewUrl != nil{
            values.append(previewUrl!)
        }
        
        if smallIconUrl != nil{
            values.append(smallIconUrl!)
        }
        
        if  contentClass != nil{
            values.append(contentClass!)
        }
        
        if size != nil{
            values.append(String(size!))
        }
        
        return values
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
        
        self.db.asynchFetch(type: NewsRealm.self, options: FetchOptionsPredicate(predicate: predicate!, sortBy: ("dateCreated", false))) { (executeNews, ctx)  in
            
            
            var convertNews:[INews] = [INews]()
            
            if executeNews.count <= count{
                convertNews = News.createNews(news: executeNews)
            }
            else {
                 convertNews = News.createNews(news: Array(executeNews[0..<count]))
            }
            
            completion(convertNews)
        }
    }
    
}
