//
//  NewsDetailsCake.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class NewsDetailsCake : INewsDetailsCake {
    
    var router: INewsDetailsRouter
    var director: INewsDetailsDirector
    var design:INewsDetailsDesign
    
    required init(router:INewsDetailsRouter,
                  director:INewsDetailsDirector,
                  design:INewsDetailsDesign){
        
        self.router = router
        self.director = director
        self.design = design
    }
}
