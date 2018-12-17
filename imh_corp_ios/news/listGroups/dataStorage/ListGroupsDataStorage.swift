//
//  ListGroupsDataStorage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 14/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class ListGroupsDataStorage : IListGroupsDataStorage {
    
    private let db:IDataBase
    
    required init(db:IDataBase) {
        self.db = db
    }
    
    func saveIdListGroupsOff(accountId:String,
                             idList:[String]){
        
        let account:AccountRealm = self.db.synchFetch(options: FetchOptionsPredicate(predicate: NSPredicate(format: "id='\(accountId)'"), sortBy: nil)).first!
        let settings:SettingsRealm = account.settings
        self.db.synch {
            settings.idListHidenNewsGroups.removeAll()
            
            for item in idList{
                settings.idListHidenNewsGroups.append(item)
            }
        }
    }
    
    func getIsListGroupsOff(accountId:String) -> [String]{
         let account:AccountRealm = self.db.synchFetch(options: FetchOptionsPredicate(predicate: NSPredicate(format: "id='\(accountId)'"), sortBy: nil)).first!
        let settings:SettingsRealm = account.settings
        return settings.getIdListHidenNewsGroups()
    }
    
    func getGroups(accountId:String,
                       completion: @escaping ([INewsGroup])->()){
        
        let predicate:NSPredicate = NSPredicate(format: "accountId='\(accountId)'")
        
        self.db.asynchFetch(type: NewsGroupRealm.self,
                            options: FetchOptionsPredicate(predicate: predicate,
                                                           sortBy: ("name", false))) {
                                                            (executeNews, ctx)  in
            
            let convertGroups:[INewsGroup] = NewsGroup.createGroups(groups: executeNews)
            completion(convertGroups)
        }
    }
    
        
    
    func createOrUpdateGroups(accountId:String,
                              groupsJson:[Any],
                              completion:@escaping ()->()){
        
        let groupDbOperations = DispatchGroup()
        groupDbOperations.enter()
        
        for item in groupsJson{
            
            if let groupDict:[String:Any] = item as? [String:Any],
                let groupId:Int = groupDict["id"] as? Int,
                let name = groupDict["name"] as? String{
                
                let groupDescription = groupDict["description"]
                
                groupDbOperations.enter()
                
                let groupIdStr = String(groupId)
                
                
                self.db.asynchFetch(type: NewsGroupRealm.self,
                                    options: FetchOptionsPredicate(predicate:
                                        NSPredicate(format: "groupId='\(groupId)' AND accountId='\(accountId)'"), sortBy: nil),
                                    completion: { (resNews, ctx) in
                                        
                                        let groupDb = resNews.first
                                        
                                        if groupDb == nil{
                                            
                                            self.db
                                                .asynchWrite(context:ctx,
                                                             transaction: { () -> ([NewsGroupRealm]) in
                                                                
                                                                let groupDb = ctx.createObj(type: NewsGroupRealm.self, value:[name ,groupIdStr,accountId, groupDescription], update: true)
                                                                
                                                                return [groupDb]
                                                                
                                                }, completion: { (_) in
                                                    groupDbOperations.leave()
                                                })
                                        }
                                        else{
                                            groupDbOperations.leave()
                                        }
                })
            }
        }
        
        groupDbOperations.leave()
        groupDbOperations.notify(queue: .main) {
            completion()
        }
    }
}
