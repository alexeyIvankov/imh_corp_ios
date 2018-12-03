//
//  ILoginDirector.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol INewsDirector : AnyObject {
    
    func loadYammerNewsToAvailableGroups(success:@escaping ()->(),
                                         failed: @escaping (NSError?)->())
    func cancelLoadloadYammerNewsToAvailableGroups()
 
    func loadYammerNews(groupId:String,
                        lastMessageId:String?,
                        success:@escaping ()->(),
                        failed: @escaping (NSError?)->())
    
    func loadAllYammerGroups(success:@escaping ()->(),
                          failed: @escaping (NSError?)->())
    
    func addAllYammerGroupsToAvailableList(completion:@escaping ()->())
    
    
    func getAllYammerGroups() -> [INewsGroup]
    
    func getYammerGroup(name:String) -> INewsGroup?
    func getYammerGroup(name:String,
                        completion:@escaping (INewsGroup?)->())
    
    func getYammerNews(completion:@escaping ([INews])->())
    
}
