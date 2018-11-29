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
                                groupsJson:[Any])
    
    func saveOrUpdateNews(accountId:String,
                          groupId:String,
                          newsJson:[Any])
}
