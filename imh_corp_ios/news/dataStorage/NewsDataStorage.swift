//
//  NewsDataStorage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 23/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class NewsDataStorage : INewsDataStorage{
    
    private let db:IDataBase
    
    required init(db:IDataBase) {
        self.db = db
    }
    
    func saveOrUpdateNewsGroups(account:IAccount,
                                groupsJson:[Any]){
    
        guard let accountDb = account as? Account else{
            return
        }
        
        for item in groupsJson{
            
            if let groupDict:[String:Any] = item as? [String:Any],
                let group_id:Int = groupDict["id"] as? Int,
                let name:String = groupDict["name"] as? String,
                let descript = groupDict["description"] as? String{
                
                let group_id_str = String(group_id)
                
                var groupDb:NewsGroup? = self.getGroup(id: group_id_str)

                self.db.synch {
                    
                    if groupDb == nil{
                        groupDb = NewsGroup()
                        accountDb.groups.append(groupDb!)
                    }
                    
                    groupDb!.groupId = group_id_str
                    groupDb!.name = name
                    groupDb?.descript = descript
                }
                
            }
        }
    }
    
    func saveOrUpdateNews(account:IAccount,
                          groupId:String,
                          newsJson:[Any]){
        
        guard let accountDb = account as? Account else{
            return
        }
        
        let groupDb:NewsGroup? = accountDb.getGroupsNews().filter(){ $0.groupId == groupId }.first as? NewsGroup
        
        guard groupDb != nil else  {
            return
        }
        
        for item in newsJson{
            
            if let newsDict:[String:Any] = item as? [String:Any],
                let newsId:Int = newsDict["id"] as? Int,
                let body:String = newsDict["body"] as? String,
                let dateCreated = newsDict["date_created"] as? String,
                body.count > 10{
                
                let newsIdStr = String(newsId)
                var newsDb:News? = self.getNews(id: newsIdStr)
                
                self.db.synch {
                    
                    if newsDb == nil{
                        newsDb = News()
                        groupDb?.news.append(newsDb!)
                    }
                    newsDb?.newsId = newsIdStr
                    newsDb?.body = body
                    newsDb?.dateCreated = dateCreated
                }
            }
        }
        
    }
    
    
    func getGroup(id:String) -> NewsGroup? {
        
        let group:NewsGroup? = self.db.synchFetch(options: FetchOptions(predicate:  NSPredicate(format: "groupId='\(id)'"), sortBy: nil)).first
        return group
    }
    
    func getNews(id:String) -> News? {
        
        let news:News? = self.db.synchFetch(options: FetchOptions(predicate:  NSPredicate(format: "newsId='\(id)'"), sortBy: nil)).first
        return news
    }
}
