//
//  INewsDataStorage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 23/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol INewsDataStorage : AnyObject {
    
    func saveOrUpdateNewsGroups(accountId:String,
                                groupsJson:[Any],
                                completion:@escaping ()->())
    
    
    func saveOrUpdateNews(accountId:String,
                          groupId:String,
                          newsJson:[Any],
                          completion:@escaping ()->())
    
    func saveLastUpdateDate(groupId:String,
                            date:Date,
                            completion:@escaping ()->())
    
    func addAllGroupsToAvailableList(accountId:String,
                                     completion:@escaping ()->())
    
    func getNewsAvailableGroups(accountId:String,
                                completion:@escaping ([INews])->())
    
    func getGroup(name:String,
                  completion:@escaping (NewsGroupRealm?)->())
    
    func getNews(id:String,
                 completion:@escaping (NewsRealm?)->())
}
