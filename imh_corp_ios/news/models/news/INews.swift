//
//  INews.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol INews :  ILimonadeItem, IServerModel {
    
    var newsId:String! { get }
    var body:String! { get }
    var dateCreated:String! { get }
    
    func getGroup() -> INewsGroup
    func getFiles() -> [IFile]
}

