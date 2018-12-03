//
//  NewsLoaderService.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 03/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class NewsLoaderService : INewsLoaderService{
    
    let sessionService:ISessionService
    let dataStorage:INewsDataStorage
    let network:INetwork
    private var operationsQueue:OperationQueue
    
    required init(sessionService:ISessionService,
                  dataStorage:INewsDataStorage,
                  network:INetwork){
        self.sessionService = sessionService
        self.dataStorage = dataStorage
        self.network = network
        operationsQueue = OperationQueue()
    }
    
    func isExecutingTransactions() -> Bool{
        if self.operationsQueue.operationCount > 0 {
            return true
        }
        else {
            return false
        }
    }
    
    func cancelAllTransactions(){
        self.operationsQueue.cancelAllOperations()
    }
    

    func addTransationToLoadBatchNews(completionBatch:@escaping ()->(),
                                      failedBatch: @escaping (NSError?)->()){
        
        let newOperation = LoadNewsOperation(sessionService: self.sessionService,
                                             dataStorage: self.dataStorage,
                                             network: self.network,
                                             success: {
            completionBatch()
        }) { (error) in
            failedBatch(error)
        }
        
        if let lastOperation = self.operationsQueue.operations.last{
            newOperation.addDependency(lastOperation)
        }
        self.operationsQueue.addOperation(newOperation)
    }
}

class LoadNewsOperation: Operation{
    
    let sessionService:ISessionService
    let dataStorage:INewsDataStorage
    let network:INetwork
    
    var failed:(NSError)->()
    var success:()->()
    
    required init(sessionService:ISessionService,
                  dataStorage:INewsDataStorage,
                  network:INetwork,
                  success:@escaping()->(),
                  failed:@escaping(NSError)->()){
        
        self.sessionService = sessionService
        self.dataStorage = dataStorage
        self.network = network
        self.success = success
        self.failed = failed
    }
    
    override func main() {
        
        let group = DispatchGroup()
        group.enter()
        
        var chechIsCanceledAndExitIfNeed = { () -> () in
            if self.isCancelled == true{
                group.leave()
                return self.success()
            }
        }
        
        self.sessionService.activeSession {(session) in
            
            guard let account = session?.getAccount() else  {
                group.leave()
                return self.failed(NSError(domain: "not authorized", code: -1, userInfo: nil))
            }
            
            chechIsCanceledAndExitIfNeed()
            
            let token = account.getAuth().accessToken!
            let accountId = account.id
            
            let availableGroups = account.getSettings().getAvailablesGroups()
            
            guard availableGroups.count > 0 else {
                group.leave()
                return self.success()
            }
            
            guard let loaderGroup = self.searchGroupToUpdate(groups: availableGroups) else {
                group.leave()
                return self.success()
            }
            
            let groupId = loaderGroup.groupId
            
            //запоминаем дату последнего обновления группы
            self.dataStorage.saveLastUpdateDate(groupId: groupId!, date: Date(), completion: {
                
                var lastMessageId:String? = loaderGroup.getLastMessageId()
                chechIsCanceledAndExitIfNeed()
                
                self.network
                    .apiDirector
                    .socialNetworkModule
                    .messagesFromGroup(groupId: groupId!,
                                       accessToken: token,
                                       networkType: "yammer", lastMessageId: lastMessageId,
                                       success: { (responce) in
                                        
                                        if self.isCancelled == true{
                                            group.leave()
                                            return self.success()
                                        }
                                        
                                        if let data = responce.success?["data"] as? [String:Any],
                                            let news = data["messages"] as? [[String:Any]]{
                                            
                                            self.dataStorage.saveOrUpdateNews(accountId: accountId!, groupId: groupId!, newsJson: news, completion: {
                                                
                                                group.leave()
                                                self.success()
                                            })
                                            
                                        }
                                        else{
                                            group.leave()
                                            self.failed(NSError(domain: "Не удалось загрузить новости", code: -1, userInfo: nil))
                                        }
                                        
                                        
                    }, failed: {  [unowned self](error) in
                        group.leave()
                        self.failed(error)
                    })
            })
            
        }
        
        group.wait()
    }
    
    private func searchGroupToUpdate(groups:[INewsGroup]) -> INewsGroup?{
        
        let sortGroups = groups.sorted(by: { (gr1, gr2) -> Bool in
            
            if let last1 = Double(gr1.lastUpdateMessages!),
                let last2 = Double(gr2.lastUpdateMessages!){
                
                if last1 < last2 {
                    return true
                }
                else {
                    return false
                }
            }
            else {
                return false
            }
        })
        return sortGroups.first
    }
}
