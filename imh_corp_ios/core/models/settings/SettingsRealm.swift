//
//  SettingsRealm.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 03/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class SettingsRealm : Object, ISettings {
    
    @objc dynamic var account:AccountRealm!
    var availableGroups = List<NewsGroupRealm>()
    
    func getAvailablesGroups() -> [INewsGroup]{
        return self.availableGroups.convertToArray()
    }
    
    func getAccount() -> IAccount{
        return self.account
    }
}
