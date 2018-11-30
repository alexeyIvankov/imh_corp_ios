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
    
    required init( network:INetwork,
                   dataStorage:INewsDataStorage,
                   sessionService:ISessionService){
        
        self.network = network
        self.dataStorage = dataStorage
        self.sessionService = sessionService
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
                                            
                                            self.dataStorage.saveOrUpdateNewsAsynch(accountId: accountId!, groupId: groupId, newsJson: news, completion: {
                                                
                                                DispatchQueue.main.async {
                                                    success()
                                                }
                                            })
                                            
                                            //                                        self.dataStorage.saveOrUpdateNews(accountId: self.session.getAccount().id, groupId: groupId, newsJson: news)
                                            
                                            //                                        DispatchQueue.main.async {
                                            //                                              success()
                                            //                                        }
                                            
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
    
    func loadYammerGroups(success:@escaping ()->(),
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
    
    func getAllYammerGroups() -> [INewsGroup]{
        
        guard let session = self.sessionService.getActiveSession() else {
            fatalError("session is nill")
        }
        return session.getAccount().getGroupsNews()
    }
    
    func getGroup(name:String) -> INewsGroup?{
        return self.getAllYammerGroups().filter() { $0.name == name }.first
    }
    
    func getGroup(id:String,
                  completion:@escaping (NewsGroup?)->()){
        return self.dataStorage.getGroup(id:id, completion:completion)
    }
    
    func getGroup(name:String,
                  completion:@escaping (NewsGroup?)->()){
        return self.dataStorage.getGroup(name:name, completion:completion)
    }
    
    func getNews(id:String,
                 completion:@escaping (News?)->()){
        return self.dataStorage.getNews(id:id,  completion:completion)
    }
    
    func getAccount(id:String,
                    completion:@escaping (Account?)->()){
        return self.dataStorage.getAccount(id:id, completion:completion)
    }
    
    func getNews(groupName:String) -> [INews]{
        var news:[INews] =  [INews]()
        
        if let group = self.getGroup(name: groupName){
            news = group.getNews()
        }
        
        return news
    }
}
