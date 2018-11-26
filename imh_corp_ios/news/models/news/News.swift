//
//  News.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class News: Object, INews {
    
    @objc dynamic var newsId:String? = nil
    @objc dynamic var body:String? = nil
    @objc dynamic var dateCreated:String? = nil
    @objc dynamic var group:NewsGroup!
    
    var files = List<File>()
    
    func getGroup() -> INewsGroup{
        return self.group
    }
    
    func getFiles() -> [IFile]{
        return self.files.toArray()
    }
}
