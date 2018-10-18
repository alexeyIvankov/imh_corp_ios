//
//  WelcomePagerCell.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class WelcomePagerCell : FSPagerViewCell, IWelcomePagerCell{
    
    //MARK: Outlets
    @IBOutlet  var labelNamePage: UILabel!
    @IBOutlet  var labelDescriptionPage: UILabel!
    
    private var page:IWelcomePage?
    
    func configure(page:IWelcomePage){
        self.page = page
        self.labelNamePage.text = page.name
        self.labelDescriptionPage.text = page.details
    }
    
}
