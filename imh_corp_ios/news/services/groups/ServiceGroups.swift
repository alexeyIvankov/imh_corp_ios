//
//  ServiceGroups.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 14/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class ServiceGroups : IServiceGroups {

    private var network:INetwork
    private var dataStorage:IListGroupsDataStorage
    private var sessionService:ISessionService
    
    required init( network:INetwork,
                   dataStorage:IListGroupsDataStorage,
                   sessionService:ISessionService){
        
        self.network = network
        self.dataStorage = dataStorage
        self.sessionService = sessionService
    }
    
    func getIdListGroupsOff() -> [String]{
        let account = self.sessionService.getActiveSession()?.getAccount()
        return self.dataStorage.getIsListGroupsOff(accountId: account!.id!)
    }
    
    func saveIdListGroupsOff(idList:[String]){
        let account = self.sessionService.getActiveSession()?.getAccount()
        self.dataStorage.saveIdListGroupsOff(accountId: account!.id, idList: idList)
    }
    
    func getMeAllGroups(oldCashedGroups: @escaping ([INewsGroup]) -> (),
                        newLoadedGroups: @escaping ([INewsGroup]) -> (),
                        failed: @escaping (NSError?) -> ()) {
        
        self.sessionService.activeSession { (session) in
            
            guard session != nil else {
                fatalError("session is nill")
            }
            
            let accountId = session!.getAccount().id!
            
            self.dataStorage.getGroups(accountId: accountId, completion: { (groups) in
                oldCashedGroups(groups)
                
                self.updateGroups(completion: { (error) in
                    
                    guard error == nil else {
                        return failed(error)
                    }
                    
                    self.dataStorage.getGroups(accountId: accountId, completion: { (groups) in
                        newLoadedGroups(groups)
                    })
                })
            })
        }
    }
    
    func updateGroups(completion:@escaping (NSError?)->()){
        
        self.sessionService.activeSession { (session) in
            
            guard session != nil else {
                fatalError("session is nill")
            }
            
            let token = session!.getAccount().getAuth().accessToken!
            let accountId = session!.getAccount().id!
            
            self.network
                .apiDirector
                .socialNetworkModule
                .allGroups(accessToken: token,
                           networkType: "yammer",
                           success: { (responce) in
                            
                            if let data = responce.success?["data"] as? [String:Any],
                                let groups = data["groups"] as? [[String:Any]]{
                                
                                self.dataStorage
                                    .createOrUpdateGroups(accountId: accountId,
                                                          groupsJson: groups,
                                                          completion: {
                                                            DispatchQueue.main.async {completion(nil)}
                                })
                                
                            }
                            else{
                                DispatchQueue.main.async {
                                    completion(NSError(domain: "Не удалось загрузить группы", code: -1, userInfo: nil))
                                }
                            }
                            
                            
            }, failed: { (error) in
                
                DispatchQueue.main.async {
                    completion(error)
                }
                
            })
        }
    }
}
