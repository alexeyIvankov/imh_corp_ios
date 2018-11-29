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
    
    func saveOrUpdateNewsGroups(accountId:String,
                                groupsJson:[Any]){
    
        guard let accountDb:Account = self.getAccount(id: accountId) else{
            return
        }
        
        for item in groupsJson{
            
            if let groupDict:[String:Any] = item as? [String:Any],
                let group_id:Int = groupDict["id"] as? Int,
                let _:String = groupDict["name"] as? String{
                
                
                let group_id_str = String(group_id)
                
                var groupDb:NewsGroup? = self.getGroup(id: group_id_str)

                self.db.synch {
                    
                    if groupDb == nil{
                        groupDb = NewsGroup()
                        accountDb.groups.append(groupDb!)
                    }
                    groupDb?.update(json: groupDict)
                }
                
            }
        }
    }
    
    func saveOrUpdateNews(accountId:String,
                          groupId:String,
                          newsJson:[Any]){
        
        guard let accountDb:Account = self.getAccount(id: accountId) else{
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
                let _ = newsDict["date_created"] as? String,
                body.count > 10{
                
                let newsIdStr = String(newsId)
                var newsDb:News? = self.getNews(id: newsIdStr)
                
                self.db.synch {
                    
                    if newsDb == nil{
                        newsDb = News()
                        groupDb?.news.append(newsDb!)
                    }
                    newsDb?.update(json: newsDict)
                    
                    let attachments = newsDict["attachments"] as? [[String:Any]]
                    
                    if attachments != nil{
                       
                        for attach_dict in attachments!{
                            
                            if let fileId = attach_dict["id"] as? Int,
                                let _ = attach_dict["type"],
                                let _ = attach_dict["content_type"],
                                let _ = attach_dict["download_url"]{
                            
                                var fileDb:File? = self.getFile(id:String(fileId))
                                if fileDb == nil{
                                    fileDb = File()
                                    newsDb?.files.append(fileDb!)
                                }
                                fileDb?.update(json: attach_dict)
                            }
                        }
                    }
                
                }
            }
        }
    }
    
    func getAccount(id:String) -> Account? {
        
        let account:Account? = self.db.synchFetch(options: FetchOptions(predicate:  NSPredicate(format: "id='\(id)'"), sortBy: nil)).first
        return account
    }
    
    func getGroup(id:String) -> NewsGroup? {
        
        let group:NewsGroup? = self.db.synchFetch(options: FetchOptions(predicate:  NSPredicate(format: "groupId='\(id)'"), sortBy: nil)).first
        return group
    }
    
    func getNews(id:String) -> News? {
        
        let news:News? = self.db.synchFetch(options: FetchOptions(predicate:  NSPredicate(format: "newsId='\(id)'"), sortBy: nil)).first
        return news
    }
    
    func getFile(id:String) -> File? {
        
        let file:File? = self.db.synchFetch(options: FetchOptions(predicate:  NSPredicate(format: "fileId='\(id)'"), sortBy: nil)).first
        return file
    }
}
