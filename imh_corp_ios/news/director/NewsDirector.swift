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
    
    func giveMeYammerNews(startDate:Int,
                          count:Int,
                          success:@escaping ([INews])->(),
                          failed: @escaping (NSError?)->()){
        
        self.sessionService.activeSession { (session) in
            
            guard session != nil else {
                fatalError("session is nill")
            }
            
            let token = session!.getAccount().getAuth().accessToken!
            let accountId = session!.getAccount().id!
            
            self.dataStorage.getNews(accountId: accountId,
                                     startDate: startDate,
                                     count: count,
                                     completion: {  (newsList) in
                
                                        if newsList.count == count{
                                            success(newsList)
                                        }
                                        else {
                                            
                                            self.loadAndSaveYammerNews(accountId: accountId,
                                                                        token: token,
                                                                        startDate: startDate,
                                                                        count: count,
                                                                        success: { 
                                                
                                                self.dataStorage.getNews(accountId: accountId,
                                                                          startDate: startDate,
                                                                          count: count,
                                                                          completion: { (newsList) in
                                                                            
                                                                            success(newsList)
                                                })
                                                
                                            }, failed: failed)
                                        }
                                    })
        }
        
    }
    
    private func loadAndSaveYammerNews(accountId:String,
                                       token:String,
                                       startDate:Int?,
                                       count:Int?,
                                       success:@escaping ()->(),
                                       failed: @escaping (NSError?)->()){
        
        
        DispatchQueue.global().async {
            self.network
                .apiDirector
                .socialNetworkModule
                .allNews(accessToken: token,
                         networkType: "yammer",
                         startDate: startDate,
                         countMessages: count,
                         success: { (responce) in
                            
                            
                            if let data = responce.success?["data"] as? [String:Any],
                                let news = data["news"] as? [[String:Any]]{
                                
                                self.dataStorage.createOrUpdateNews(accountId: accountId, newsJson: news, completion: {
                                    success()
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
