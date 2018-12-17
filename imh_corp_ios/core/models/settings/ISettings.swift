//
//  ISettings.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 03/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol ISettings {
 
    func getIdListHidenNewsGroups() -> [String]
    func getAccount() -> IAccount
}
