//
//  IFile.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

enum FileType:String {
    case image = "image"
}

public protocol IFile {
    
    var fileId: String! { get }
    var newsId: String! { get }
    var name: String? { get }
    var type: String! { get }
    var contentType: String! { get }
    var dateCreated: String? { get }
    var largeIconUrl: String? { get }
    var previewUrl: String? { get }
    var smalIconUrl: String? { get }
    var size: String? { get }
    var url: String? { get }
    var localPath: String? { get }
    var contentClass: String? { get }
}
