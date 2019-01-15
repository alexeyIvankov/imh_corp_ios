//
//  ServiceNews.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 07/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class ServiceNews: IServiceNews {
    
    private var network:INetwork
    private var dataStorage:INewsDataStorage
    private var sessionService:ISessionService
    private var state:ServiceNewsState = .ready
    
    
    required init( network:INetwork,
                   dataStorage:INewsDataStorage,
                   sessionService:ISessionService){
        
        self.network = network
        self.dataStorage = dataStorage
        self.sessionService = sessionService
    }
    
    func getState() -> ServiceNewsState{
        return self.state
    }
    
    private func setState(state:ServiceNewsState){
        self.state = state
    }
    
    func giveMeYammerNews(startDate:Int?,
                          endDate:Int?,
                          count:Int,
                          oldCashedNews:@escaping ([INews])->(),
                          newLoadedNews:@escaping ([INews])->(),
                          failed: @escaping (NSError?)->()){
        
        self.setState(state: .busy)
        self.sessionService.activeSession { (session) in
            
            guard session != nil else {
                fatalError("session is nill")
            }
            
            let token = session!.getAccount().getAuth().accessToken!
            let accountId = session!.getAccount().id!
            
            self.dataStorage.getNews(accountId: accountId,
                                     startDate: startDate,
                                     endDate: endDate,
                                     count: count,
                                     completion: {  (newsList) in
                                        
                                        oldCashedNews(newsList)
                                        
                                        self.loadAndSaveYammerNews(accountId: accountId,
                                                                   token: token,
                                                                   startDate: startDate,
                                                                   endDate: endDate,
                                                                   count: count,
                                                                   success: {
                                                                    
                                                                    self.dataStorage.getNews(accountId: accountId,
                                                                                             startDate:startDate,
                                                                                             endDate: endDate,
                                                                                             count: count,
                                                                                             completion: { (newsList) in
                                                                                                
                                                                                                newLoadedNews(newsList)
                                                                                                self.setState(state: .ready)
                                                                    })
                                                                    
                                        }, failed: { (error) in
                                            failed(error)
                                            self.setState(state: .ready)
                                        })
            })
        }
    }
    
    func giveMeYammerNewsExceptGroups(groupsIdList:[String],
                                      startDate:Int?,
                                      endDate:Int?,
                                      count:Int,
                                      oldCashedNews:@escaping ([INews])->(),
                                      newLoadedNews:@escaping ([INews])->(),
                                      failed: @escaping (NSError?)->()){
        
        self.setState(state: .busy)
        self.sessionService.activeSession { (session) in
            
            guard session != nil else {
                fatalError("session is nill")
            }
            
            let token = session!.getAccount().getAuth().accessToken!
            let accountId = session!.getAccount().id!
            
            self.dataStorage.getNewsExceptGroups(groupsIdList: groupsIdList, accountId: accountId, startDate: startDate, endDate: endDate, count: count, completion: { (newsList) in
                
                oldCashedNews(newsList)
                
                if newsList.count < count {
                    
                    var intGroupsIdList:[Int] = [Int]()
                    
                    for groupIdString in groupsIdList{
                        
                        if let intGroupId:Int  = Int(groupIdString){
                            intGroupsIdList.append(intGroupId)
                        }
                    }
                    
                    self.loadAndSaveYammerNewsExceptGroups(groupsIdList:intGroupsIdList,
                                                           accountId: accountId,
                                                           token: token,
                                                           startDate: startDate,
                                                           endDate: endDate,
                                                           count: count,
                                                           success: {
                                                
                                                self.dataStorage.getNewsExceptGroups(groupsIdList: groupsIdList,accountId: accountId,
                                                                         startDate:startDate,
                                                                         endDate: endDate,
                                                                         count: count,
                                                                         completion: { (newsList) in
                                                                            
                                                                            newLoadedNews(newsList)
                                                                            self.setState(state: .ready)
                                                })
                                                
                    }, failed: { (error) in
                        failed(error)
                        self.setState(state: .ready)
                    })
                    
                }
                else {
                    self.setState(state: .ready)
                }
            })
        }
    }
    
    
    private func loadAndSaveYammerNews(accountId:String,
                                       token:String,
                                       startDate:Int?,
                                       endDate:Int?,
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
                         endDate: endDate,
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

 
    private func loadAndSaveYammerNewsExceptGroups(groupsIdList:[Int],
                                                   accountId:String,
                                                   token:String,
                                                   startDate:Int?,
                                                   endDate:Int?,
                                                   count:Int?,
                                                   success:@escaping ()->(),
                                                   failed: @escaping (NSError?)->()){
        
        
        DispatchQueue.global().async {
            self.network
                .apiDirector
                .socialNetworkModule
                .newsExceptGroups(accessToken: token,
                         networkType: "yammer",
                         groupsIdList:groupsIdList,
                         startDate: startDate,
                         endDate: endDate,
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
