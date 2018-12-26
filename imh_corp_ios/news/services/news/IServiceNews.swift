//
//  IServiceNews.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 07/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public enum ServiceNewsState {
    case busy
    case ready
}

public protocol IServiceNews : AnyObject{
    
    func getState() -> ServiceNewsState
    
    func giveMeYammerNews(startDate:Int?,
                          endDate:Int?,
                          count:Int,
                          oldCashedNews:@escaping ([INews])->(),
                          newLoadedNews:@escaping ([INews])->(),
                          failed: @escaping (NSError?)->())
    
    func giveMeYammerNewsExceptGroups(groupsIdList:[String],
                                      startDate:Int?,
                                      endDate:Int?,
                                      count:Int,
                                      oldCashedNews:@escaping ([INews])->(),
                                      newLoadedNews:@escaping ([INews])->(),
                                      failed: @escaping (NSError?)->())
    
}
