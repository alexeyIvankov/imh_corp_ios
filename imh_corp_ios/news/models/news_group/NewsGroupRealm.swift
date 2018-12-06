//
//  NewsGroupRealm.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class NewsGroupRealm: Object, INewsGroup {

    @objc dynamic var name:String! = nil
    @objc dynamic var groupId:String! = nil
    @objc dynamic var accountId:String! = nil
    @objc dynamic var descript:String! = nil
}
