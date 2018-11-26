//
//  INewsDataStorage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 23/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol INewsDataStorage : AnyObject {
    
    func saveOrUpdateNewsGroups(account:IAccount,
                                groupsJson:[Any])
    
    func saveOrUpdateNews(account:IAccount,
                          groupId:String,
                          newsJson:[Any])
}
