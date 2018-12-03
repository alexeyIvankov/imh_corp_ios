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
    
    func saveOrUpdateNewsGroups(accountId:String,
                                groupsJson:[Any],
                                completion:@escaping ()->()){
        
        self.db.asynchFetch(type: AccountRealm.self, options: FetchOptions(predicate:  NSPredicate(format: "id='\(accountId)'"), sortBy: nil)) { (res, context)  in
         
            guard let account = res.first else  {
                return completion()
            }
            
            var transactions = [()->()]()
        
            for item in groupsJson{
                
                if let groupDict:[String:Any] = item as? [String:Any],
                    let group_id:Int = groupDict["id"] as? Int,
                    let _:String = groupDict["name"] as? String{
                    
                    let group_id_str = String(group_id)
                    
                    self.db.asynchFetch(context:context,
                                        type: NewsGroupRealm.self,
                                        options: FetchOptions(predicate:  NSPredicate(format: "groupId='\(group_id_str)'"), sortBy: nil), completion: { (resGroups, ctx) in
                        
                                            var group = resGroups.first
                                            
                                            transactions.append {
                                                
                                                if group == nil{
                                                    group = NewsGroupRealm()
                                                    group?.groupId = group_id_str
                                                    account.groups.append(group!)
                                                    group?.account = account
                                                }
                                                group?.update(json: groupDict)
                                            }
                        })
                }
            }
            self.db.asynch(context: context, transactions: transactions, completion: { (_) in
                completion()
            })
        }
    }
    
    func saveOrUpdateNews(accountId:String,
                          groupId:String,
                          newsJson:[Any],
                          completion:@escaping ()->()){
        
        self.db.asynchFetch(type: AccountRealm.self, options: FetchOptions(predicate:  NSPredicate(format: "id='\(accountId)'"), sortBy: nil)) { (res, context)  in
            
            guard res.first != nil else  {
                return completion()
            }
            
            self.db.asynchFetch(context:context,
                                type: NewsGroupRealm.self,
                                options: FetchOptions(predicate:  NSPredicate(format: "groupId='\(groupId)'"), sortBy: nil), completion: { (resGroups, ctx) in
                                    
                                    let group = resGroups.first
                                    
                                    guard group != nil else  {
                                        return completion()
                                    }
                                    
                                    var transactions = [()->()]()
                                    
                                    for item in newsJson{
                                        
                                        if let newsDict:[String:Any] = item as? [String:Any],
                                            let newsId:Int = newsDict["id"] as? Int,
                                            let body:String = newsDict["body"] as? String,
                                            let _ = newsDict["date_created"] as? String,
                                            body.count > 10{
                                            
                                            let newsIdStr = String(newsId)
                                            
                                            self.db.asynchFetch(context:ctx, type: NewsRealm.self, options: FetchOptions(predicate:  NSPredicate(format: "newsId='\(newsIdStr)'"), sortBy: nil), completion: { (resNews, ctx) in
                                                
                                                var newsDb = resNews.first
                                                
                                                transactions.append {
                                                    
                                                    if newsDb == nil{
                                                        newsDb = NewsRealm()
                                                        newsDb?.newsId = newsIdStr
                                                        group?.news.append(newsDb!)
                                                        newsDb?.group = group
                                                    }
                                                    newsDb?.update(json: newsDict)
                                                }
                                            })
                                        }
                                    }
                                    self.db.asynch(context: context, transactions: transactions, completion: { (_) in
                                        completion()
                                    })
            })
        }
    }
    
    func saveLastUpdateDate(groupId:String,
                            date:Date,
                            completion:@escaping ()->()){
        
        self.db.asynchFetch(type: NewsGroupRealm.self, options: FetchOptions(predicate:  NSPredicate(format: "groupId='\(groupId)'"), sortBy: nil)) { (res, ctx) in
            
            guard let group = res.first else {
                return completion()
            }
            
            self.db.asynch(context: ctx, block: {
                
                group.lastUpdateMessages = String(date.timeIntervalSince1970)
                
            }, completion: { (_) in
                completion()
            })

        }
        
    }
    
    func addAllGroupsToAvailableList(accountId:String,
                                     completion:@escaping ()->()){
        
        self.db.asynchFetch(type: AccountRealm.self, options: FetchOptions(predicate:  NSPredicate(format: "id='\(accountId)'"), sortBy: nil)) { (res, context)  in
            
            guard let account = res.first else  {
                return completion()
            }
            
            self.db.asynch(context: context, block: {
                
                let groups = account.groups
                for group in groups {
                    if account.settings.availableGroups.contains(group) == false{
                        account.settings.availableGroups.append(group)
                    }
                }
                
            }, completion: { (_) in
                completion()
            })
        }
    }
    
    func getNewsAvailableGroups(accountId:String,
                                completion:@escaping ([INews])->()){
        
        self.db.asynchFetch(type: NewsRealm.self,
                            options: FetchOptions(predicate:  NSPredicate(format: "group.account.id='\(accountId)'"), sortBy: nil),
                            completion: { (resNews, _) in
                                completion(News.createNews(news: resNews))
                                
        })
    }

    
    func getAccount(id:String, completion:@escaping (AccountRealm?)->()){
        
        self.db.asynchFetch(type: AccountRealm.self, options: FetchOptions(predicate:  NSPredicate(format: "id='\(id)'"), sortBy: nil)) { (res, ctx)  in
            completion(res.first)
        }
    }
    
    func getAccount(id:String) -> AccountRealm? {
        
        let account:AccountRealm? = self.db.synchFetch(options: FetchOptions(predicate:  NSPredicate(format: "id='\(id)'"), sortBy: nil)).first
        return account
    }
    
    func getGroup(id:String, completion:@escaping (NewsGroupRealm?)->()){
        
        self.db.asynchFetch(type: NewsGroupRealm.self, options: FetchOptions(predicate:  NSPredicate(format: "groupId='\(id)'"), sortBy: nil)) { (res, ctx) in
            completion(res.first)
        }
    }
    
    func getGroup(name:String,
                  completion:@escaping (NewsGroupRealm?)->()){
        
        self.db.asynchFetch(type: NewsGroupRealm.self, options: FetchOptions(predicate:  NSPredicate(format: "name='\(name)'"), sortBy: nil)) { (res, ctx) in
            completion(res.first)
        }
    }
    
    
    func getNews(id:String, completion:@escaping (NewsRealm?)->()){
        
        self.db.asynchFetch(type: NewsRealm.self, options: FetchOptions(predicate:  NSPredicate(format: "newsId='\(id)'"), sortBy: nil)) { (res, ctx) in
            completion(res.first)
        }
    }
    
    func getNews(id:String) -> NewsRealm? {
        
        let news:NewsRealm? = self.db.synchFetch(options: FetchOptions(predicate:  NSPredicate(format: "newsId='\(id)'"), sortBy: nil)).first
        return news
    }
    
    func getFile(id:String) -> FileRealm? {
        
        let file:FileRealm? = self.db.synchFetch(options: FetchOptions(predicate:  NSPredicate(format: "fileId='\(id)'"), sortBy: nil)).first
        return file
    }
    
    func getFile(id:String, completion:@escaping (FileRealm?)->()){
        
        self.db.asynchFetch(type: FileRealm.self, options: FetchOptions(predicate:  NSPredicate(format: "fileId='\(id)'"), sortBy: nil)) { (res, ctx) in
            completion(res.first)
        }
    }
}
