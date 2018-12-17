//
//  IServiceGroups.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 14/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol IServiceGroups : AnyObject{
    
    func updateGroups(completion:@escaping (NSError?)->())
    
    func getMeAllGroups(oldCashedGroups:@escaping ([INewsGroup])->(),
                        newLoadedGroups:@escaping ([INewsGroup])->(),
                        failed: @escaping (NSError?)->())
    
    func getIdListGroupsOff()->[String]
    func saveIdListGroupsOff(idList:[String])
}
