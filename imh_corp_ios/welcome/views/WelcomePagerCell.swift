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
    @IBOutlet  var labelNamePage: RQShineLabel!
    @IBOutlet  var labelDescriptionPage: RQShineLabel!

    
    private var page:IWelcomePage?
    
    override func awakeFromNib() {
        self.labelNamePage.textColor = UIColor.black
        self.labelDescriptionPage.textColor = UIColor.black
    }
    
    func configure(page:IWelcomePage){
        self.page = page
        self.labelNamePage.text = page.name
        self.labelDescriptionPage.text = page.details
    }
    
    func startDisplayAnimation() {
        self.labelNamePage.shine()
        self.labelDescriptionPage.shine()
    }
    
    func stopDisplayAnimation() {
        self.labelNamePage.clearAllAnimations()
        self.labelDescriptionPage.clearAllAnimations()
    }
    
}
