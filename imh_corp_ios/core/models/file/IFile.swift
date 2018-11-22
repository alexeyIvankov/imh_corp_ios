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

public protocol IFile : AnyObject {
    
    var name:String? { get }
    var type:String? { get }
    var localPath:String? { get }
    var remoteUrl:String? { get }
}
