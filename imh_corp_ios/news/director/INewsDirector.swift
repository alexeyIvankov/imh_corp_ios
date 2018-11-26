//
//  ILoginDirector.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol INewsDirector : AnyObject {
 
    func loadYammerNews(groupId:String,
                        success:@escaping ()->(),
                        failed: @escaping (NSError?)->())
    
    func loadYammerGroups(success:@escaping ()->(),
                          failed: @escaping (NSError?)->())
    
    func getAllYammerGroups() -> [INewsGroup]
    func getGroup(name:String) -> INewsGroup?
    func getNews(groupName:String) -> [INews]
}
