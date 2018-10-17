//
//  IWelcomePageDataSource.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 17.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IWelcomePagesDataSource : AnyObject {
    func getPages() -> [IWelcomePage]
}
