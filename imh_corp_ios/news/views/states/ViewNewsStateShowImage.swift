//
//  ViewNewsStateShowImage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class ViewNewsStateShowImage: ViewNewsStateOnlyText{
    
    @IBOutlet weak var imageViewNews:UIImageView!
    
    override func configure(news: INews) {
        super.configure(news: news)
    }
}
