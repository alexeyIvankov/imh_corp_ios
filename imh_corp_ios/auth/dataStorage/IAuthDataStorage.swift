//
//  IAuthDataStorage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 22/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IAuthDataStorage {

    func trySaveAuthorization(account:[String:Any])
}
