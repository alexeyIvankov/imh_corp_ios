//
//  INetwork.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 23.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import imh_corp_ios_api

protocol INetwork : AnyObject {
    var apiDirector:IAPIDirector { get }
}
