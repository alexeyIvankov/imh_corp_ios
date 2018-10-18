//
//  IWelcomePagerCell.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IWelcomePagerCell : IViewWithDisplayAnimation {
    
    func configure(page:IWelcomePage)
}
