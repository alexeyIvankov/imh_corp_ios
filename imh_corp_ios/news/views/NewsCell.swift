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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addTopContentInset()
    }
    
    func configure(news: INews) {
        self.labelTitleNews.text = news.body
        self.labelSubTitleNews.text = news.body
        //self.labelGroupName.text = news.getGroup().name
    }
    
    private func addTopContentInset(){
        let frameContentView = contentView.frame
        let correctFrame = frameContentView.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0))
        contentView.frame = correctFrame
    }
}
