//
//  Settings.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 03/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation


class Settings : ISettings {
  
    var account:IAccount!
    var idListHidenNewsGroups:[String] = []
    
    required init(settings:ISettings) {
        self.account = settings.getAccount()
        self.idListHidenNewsGroups = settings.getIdListHidenNewsGroups()
    }
    
    func getIdListHidenNewsGroups() -> [String] {
        return self.idListHidenNewsGroups
    }
    
    func getAccount() -> IAccount {
        return self.account
    }
}
