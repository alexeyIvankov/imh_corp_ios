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
    @IBOutlet weak var labelDateCreated:UILabel!
    
    var dateFormaterConverter:DateFormatter {
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formater
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addTopContentInset()
    }
    
    func configure(news: INews) {
        self.labelTitleNews.text = news.body
        self.labelSubTitleNews.text = news.body
        self.labelGroupName.text = "#" + news.getGroup().name
        
        if let timeIntervalDate = TimeInterval(news.dateCreated){
            let date = Date.init(timeIntervalSince1970: timeIntervalDate)
            self.labelDateCreated.text = self.dateFormaterConverter.string(from:date)
        }
    }
    
    private func addTopContentInset(){
        let frameContentView = contentView.frame
        let correctFrame = frameContentView.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0))
        contentView.frame = correctFrame
    }
}
