//
//  File.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import RealmSwift

class File : Object, IFile{
    
    @objc dynamic var name: String? = nil
    @objc dynamic var type: String? = nil
    @objc dynamic var localPath: String? = nil
    @objc dynamic var remoteUrl: String? = nil
}
