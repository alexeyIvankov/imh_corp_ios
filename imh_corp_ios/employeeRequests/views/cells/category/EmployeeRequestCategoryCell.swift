//
//  EmployeeRequestCategoryCell.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 10/01/2019.
//  Copyright © 2019 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class EmployeeRequestCategoryCell: UITableViewCell, IEmployeeRequestCategoryCell {
    
    @IBOutlet var labelName:UILabel!
    @IBOutlet var imageViewIcon:UIImageView!
    
    private var category:IEmployeeRequestCategory!
    
    func configure(category:IEmployeeRequestCategory){
        self.category = category
        
        self.labelName.text = self.category.name
        self.imageViewIcon.image = self.iconCagegoryFrom(type: self.category.type)
    }
    
    private func iconCagegoryFrom(type:EmployeeRequestCategoryType) -> UIImage?{
        
        switch type {
        case .salaryInformation:
            return UIImage(named: "money_item_icon")
        case .personnelInformation:
            return UIImage(named: "man_item_icon")
        case .education:
            return UIImage(named: "hat_item_icon")
        case .requests:
            return UIImage(named: "questions_item_icon")
        case .templates:
            return UIImage(named: "paper_item_icon")
            
        }
    }
}
