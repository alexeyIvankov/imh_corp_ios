//
//  NewsDetailsCake.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class ListGroupsNewsCake : IListGroupsNewsCake {
    
    var router: IListGroupsNewsRouter
    var director: IListGroupsNewsDirector
    var design:IListGroupsNewsDesign
    
    required init(router:IListGroupsNewsRouter,
                  director:IListGroupsNewsDirector,
                  design:IListGroupsNewsDesign){
        
        self.router = router
        self.director = director
        self.design = design
    }
}
