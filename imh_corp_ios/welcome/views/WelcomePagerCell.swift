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
    @IBOutlet var labelNamePage: RQShineLabel!
    @IBOutlet var labelDescriptionPage: RQShineLabel!
    @IBOutlet var viewContainerPageImage:UIView!
    @IBOutlet var imageViewPage:UIImageView!

    private var page:IWelcomePage?
    
    override func awakeFromNib() {
    }
    
    func configure(page:IWelcomePage){
        self.page = page
        self.labelNamePage.text = page.name
        self.labelDescriptionPage.text = page.details
        self.imageViewPage.image = page.image
    }
    
    func startDisplayAnimation() {
        self.labelNamePage.shine()
        self.labelDescriptionPage.shine()
        
        self.imageViewPage.alpha = 0
        
        UIView.animate(withDuration: 2) {
            self.imageViewPage.alpha = 1
        }
    }
    
    func stopDisplayAnimation() {
        self.labelNamePage.clearAllAnimations()
        self.labelDescriptionPage.clearAllAnimations()
    }
    
}
