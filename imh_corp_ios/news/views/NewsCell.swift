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
  
    @IBOutlet weak var labelTitleNews:UILabel!
    @IBOutlet weak var labelSubTitleNews:UILabel!
    @IBOutlet weak var labelGroupName:UILabel!
    
    func configure(news: INews) {
        self.labelTitleNews.text = news.body
        self.labelSubTitleNews.text = news.body
        //self.labelGroupName.text = news.getGroup().name
    }
}
