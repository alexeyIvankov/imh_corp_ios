//
//  LoginDirector.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class NewsDirector : INewsDirector {

    var network:INetwork
    var dataStorage:INewsDataStorage
    var sessionService:ISessionService
    var newsLoaderService:INewsLoaderService
    
    required init( network:INetwork,
                   dataStorage:INewsDataStorage,
                   sessionService:ISessionService,
                   newsLoaderSerice:INewsLoaderService){
        
        self.network = network
        self.dataStorage = dataStorage
        self.sessionService = sessionService
        self.newsLoaderService = newsLoaderSerice
    }
    
    func loadYammerNewsToAvailableGroups(success:@escaping ()->(),
                                         failed: @escaping (NSError?)->()){
        self.newsLoaderService.addTransationToLoadBatchNews(completionBatch: success, failedBatch: failed)
    }
    
    func cancelLoadloadYammerNewsToAvailableGroups(){
        self.newsLoaderService.cancelAllTransactions()
    }
  
    func loadYammerNews(groupId:String,
                        lastMessageId:String?,
                        success:@escaping ()->(),
                        failed: @escaping (NSError?)->()) {
        
        self.sessionService.activeSession { (session) in
            
            guard session != nil else {
                fatalError("session is nill")
            }
            
            let token = session!.getAccount().getAuth().accessToken!
            let accountId = session!.getAccount().id
            
            
            DispatchQueue.global().async {
                
                self.network
                    .apiDirector
                    .socialNetworkModule
                    .messagesFromGroup(groupId: groupId,
                                       accessToken: token,
                                       networkType: "yammer", lastMessageId: lastMessageId,
                                       success: { (responce) in
                                        
                                        if let data = responce.success?["data"] as? [String:Any],
                                            let news = data["messages"] as? [[String:Any]]{
                                            
                                            self.dataStorage.saveOrUpdateNews(accountId: accountId!, groupId: groupId, newsJson: news, completion: {
                                                
                                                DispatchQueue.main.async {
                                                    success()
                                                }
                                            })
                                            
                                        }
                                        else{
                                            DispatchQueue.main.async {
                                                failed(NSError(domain: "Не удалось загрузить новости", code: -1, userInfo: nil))
                                            }
                                        }
                                        
                                        
                    }, failed: failed)
            }
        }
    }
    
    func loadAllYammerGroups(success:@escaping ()->(),
                    failed: @escaping (NSError?)->()){
        
        self.sessionService.activeSession { (session) in
            
            guard session != nil else {
                fatalError("session is nill")
            }
            
            let token = session!.getAccount().getAuth().accessToken!
            let accountId = session!.getAccount().id
            
            DispatchQueue.global().async {
                
                self.network.apiDirector.socialNetworkModule.allGroups(accessToken:token, networkType: "yammer", success: { (responce) in
                    
                    if let data = responce.success?["data"] as? [String:Any],
                        let groups = data["groups"] as? [Any]{
                        
                        self.dataStorage.saveOrUpdateNewsGroups(accountId: accountId!, groupsJson: groups, completion: {
                            
                            success()
                        })
                    }
                    else{
                        
                        DispatchQueue.main.async {
                            failed(NSError(domain: "Не удалось загрузить группы!", code: -1, userInfo: nil))
                        }
                    }
                    
                }, failed: failed)
            }
        }
    }
    
    func addAllYammerGroupsToAvailableList(completion:@escaping ()->()){
        
        self.sessionService.activeSession { (session) in
            
            if session == nil{
                fatalError("session is nill")
            }
            
            self.dataStorage.addAllGroupsToAvailableList(accountId: session!.getAccount().id, completion: completion)
        }
      
    }
    
    func getAllYammerGroups() -> [INewsGroup]{
        
        guard let session = self.sessionService.getActiveSession() else {
            fatalError("session is nill")
        }
        let groupsRealm = session.getAccount().getGroupsNews()
        return NewsGroup.createGroups(groups: groupsRealm)
    }
    
    func getYammerGroup(name:String) -> INewsGroup?{
        let groupRealm = self.getAllYammerGroups().filter() { $0.name == name }.first
        guard groupRealm != nil else {
            return nil
        }
        return NewsGroup(newsGroup: groupRealm!)
    }
    
    
    func getYammerGroup(name:String,
                  completion:@escaping (INewsGroup?)->()){
        
        self.dataStorage.getGroup(name: name) { (groupRealm) in
            
            if groupRealm == nil{
                completion(nil)
            }
            else {
                completion(NewsGroup.createGroup(group: groupRealm!))
            }
        }
    }
    
    func getYammerNews(completion:@escaping ([INews])->()){
        
        self.sessionService.activeSession { (session) in
            
            if session == nil{
                fatalError("session is nill")
            }
            
           self.dataStorage.getNewsAvailableGroups(accountId: session!.getAccount().id, completion: completion)
        }
    }
}
