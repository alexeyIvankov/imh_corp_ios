//
//  INewsDataStorage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 23/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol INewsDataStorage : AnyObject {
    
    func createOrUpdateNews(accountId:String,
                            newsJson:[Any],
                            completion:@escaping ()->())
    
    
    func getNews(accountId:String,
                 startDate:Int?,
                 endDate:Int?,
                 count:Int,
                 completion:@escaping ([INews])->())
    
    func getIdListGroupsOff(accountId:String) -> [String]
}
