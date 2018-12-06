//
//  NewsGroup.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 30/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class NewsGroup : INewsGroup {
    
    var name: String!
    var groupId: String!
    var accountId:String!
    var descript: String!
    
    static func createGroups(groups:[INewsGroup]) -> [INewsGroup]{
        var container = [INewsGroup]()
        
        for item in groups{
            let group = NewsGroup(newsGroup: item)
            container.append(group)
        }
        return container
    }
    
    static func createGroup(group:INewsGroup) -> INewsGroup{
        let newGroup = NewsGroup(newsGroup: group)
        return newGroup
    }
    
    required init(newsGroup:INewsGroup){
        self.name = newsGroup.name
        self.groupId = newsGroup.groupId
        self.accountId = newsGroup.accountId
        self.descript = newsGroup.descript
    }
}
