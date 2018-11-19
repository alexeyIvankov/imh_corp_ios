//
//  NewsCell.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 19/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class NewCell : UITableViewCell,  INewsCell{
    
    @IBOutlet weak var viewStateOnlyText:ViewNewsStateOnlyText!
    @IBOutlet weak var viewStateShowImage:ViewNewsStateShowImage!
    
    func configure(news: INews) {
        
        self.viewStateShowImage.isHidden = true
        self.viewStateOnlyText.isHidden = true
        
        if news.getFiles().count == 0 {
            self.viewStateOnlyText.configure(news: news)
            self.viewStateOnlyText.isHidden = false
        }
        else {
            self.viewStateShowImage.configure(news: news)
            self.viewStateShowImage.isHidden = false
        }
    }
}
