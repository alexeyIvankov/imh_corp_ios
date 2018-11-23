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
  
    func loadNews() {
        
    }
    
    func loadYammerGroups(success:@escaping ()->(),
                    failed: @escaping (NSError?)->()){
        self.network.apiDirector.socialNetworkModule.allGroups(accessToken:self.session.getAccount().getAuth().accessToken!, networkType: "yammer", success: { (responce) in
         
            if let data = responce.success?["data"] as? [String:Any],
                let groups = data["groups"] as? [Any]{
                self.dataStorage.saveOrUpdateOrDeleteExessNewsGroups(account: self.session.getAccount(), groupsJson: groups)
                success()
            }
            else{
                failed(NSError(domain: "Не удалось загрузить группы!", code: -1, userInfo: nil))
            }

        }, failed: failed)
    }
    
    func getAllGroups() -> [INewsGroup]{
        return self.session.getAccount().getGroupsNews()
    }
    
}
