//
//  WelcomeDirector.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class WelcomeDirector : IWelcomeDirector{
    let dataSource:IWelcomePagesDataSource
    
    required init(dataSource:IWelcomePagesDataSource){
        self.dataSource = dataSource
    }
    
    func getPages() -> [IWelcomePage]{
        return self.dataSource.getPages()
    }
}
