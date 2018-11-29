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
    var session:ISession
    
    required init( network:INetwork,
                   dataStorage:INewsDataStorage,
                   session:ISession){
        
        self.network = network
        self.dataStorage = dataStorage
        self.session = session
    }
  
    func loadYammerNews(groupId:String,
                        lastMessageId:String?,
                        success:@escaping ()->(),
                        failed: @escaping (NSError?)->()) {
        
        let token = self.session.getAccount().getAuth().accessToken!
        
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
                                        self.dataStorage.saveOrUpdateNews(accountId: self.session.getAccount().id, groupId: groupId, newsJson: news)
                                        
                                        DispatchQueue.main.async {
                                              success()
                                        }
                                      
                                    }
                                    else{
                                        DispatchQueue.main.async {
                                             failed(NSError(domain: "Не удалось загрузить новости", code: -1, userInfo: nil))
                                        }
                                    }
                                    
                                    
                }, failed: failed)
            
        }
    }
    
    func loadYammerGroups(success:@escaping ()->(),
                    failed: @escaping (NSError?)->()){
        
          let token = self.session.getAccount().getAuth().accessToken!
        
        DispatchQueue.global().async {
            
            self.network.apiDirector.socialNetworkModule.allGroups(accessToken:token, networkType: "yammer", success: { (responce) in
                
                if let data = responce.success?["data"] as? [String:Any],
                    let groups = data["groups"] as? [Any]{
                    self.dataStorage.saveOrUpdateNewsGroups(accountId: self.session.getAccount().id, groupsJson: groups)
                    
                    DispatchQueue.main.async {
                        success()
                    }
                }
                else{
                    
                    DispatchQueue.main.async {
                        failed(NSError(domain: "Не удалось загрузить группы!", code: -1, userInfo: nil))
                    }
                }
                
            }, failed: failed)
        }
    }
    
    func getAllYammerGroups() -> [INewsGroup]{
        return self.session.getAccount().getGroupsNews()
    }
    
    func getGroup(name:String) -> INewsGroup?{
        return self.getAllYammerGroups().filter() { $0.name == name }.first
    }
    
    func getNews(groupName:String) -> [INews]{
        var news:[INews] =  [INews]()
        
        if let group = self.getGroup(name: groupName){
            news = group.getNews()
        }
        
        return news
    }
}
