//
//  IServerModel.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 29/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol IServerModel: AnyObject {
    func update(json:[String:Any])
}
