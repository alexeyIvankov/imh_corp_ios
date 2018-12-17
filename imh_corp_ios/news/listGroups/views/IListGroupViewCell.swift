//
//  IListGroupViewCell.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 14/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

protocol  IListGroupViewCell {
    func configure(group:INewsGroup)
    
    func getActiveState() -> Bool
    func setActiveState(active:Bool)
}
