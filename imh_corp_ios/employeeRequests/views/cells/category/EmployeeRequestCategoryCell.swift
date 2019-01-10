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
    
    private var category:IEmployeeRequestCategory!
    
    func configure(category:IEmployeeRequestCategory){
        self.category = category
        
        self.labelName.text = self.category.name
    }
}
