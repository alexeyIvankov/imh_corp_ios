//
//  IListGroupsDataStorage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 14/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IListGroupsDataStorage : AnyObject {
    
    func getGroups(accountId:String,
                   completion: @escaping ([INewsGroup])->())
    
    func createOrUpdateGroups(accountId:String,
                              groupsJson:[Any],
                              completion:@escaping ()->())
    
    func saveIdListGroupsOff(accountId:String,
                             idList:[String])
    
    func getIsListGroupsOff(accountId:String) -> [String]
}
