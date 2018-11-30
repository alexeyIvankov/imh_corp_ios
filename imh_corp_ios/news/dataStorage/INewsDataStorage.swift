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
                          newsJson:[Any])
    
    func saveOrUpdateNewsAsynch(accountId:String,
                                groupId:String,
                                newsJson:[Any],
                                completion:@escaping ()->())
    
    func getGroup(id:String,
                  completion:@escaping (NewsGroup?)->())
    
    func getGroup(name:String,
                  completion:@escaping (NewsGroup?)->())
    
    func getNews(id:String,
                 completion:@escaping (News?)->())
    
    func getAccount(id:String,
                    completion:@escaping (Account?)->())
}
