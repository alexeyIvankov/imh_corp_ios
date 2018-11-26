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
                        success:@escaping ()->(),
                        failed: @escaping (NSError?)->()) {
        
        self.network.apiDirector.socialNetworkModule.messagesFromGroup(groupId: groupId,
                                                                       accessToken: self.session.getAccount().getAuth().accessToken!,
                                                                       networkType: "yammer",
                                                                       success: { (responce) in
                                                                        
                                                                        if let data = responce.success?["data"] as? [String:Any],
                                                                            let news = data["messages"] as? [Any]{
                                                                            self.dataStorage.saveOrUpdateNews(account: self.session.getAccount(), groupId: groupId, newsJson: news)
                                                                            success()
                                                                        }
                                                                        else{
                                                                            failed(NSError(domain: "Не удалось загрузить новости", code: -1, userInfo: nil))
                                                                        }
            
        }, failed: failed)
    }
    
    func loadYammerGroups(success:@escaping ()->(),
                    failed: @escaping (NSError?)->()){
        self.network.apiDirector.socialNetworkModule.allGroups(accessToken:self.session.getAccount().getAuth().accessToken!, networkType: "yammer", success: { (responce) in
         
            if let data = responce.success?["data"] as? [String:Any],
                let groups = data["groups"] as? [Any]{
                self.dataStorage.saveOrUpdateNewsGroups(account: self.session.getAccount(), groupsJson: groups)
                success()
            }
            else{
                failed(NSError(domain: "Не удалось загрузить группы!", code: -1, userInfo: nil))
            }

        }, failed: failed)
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
