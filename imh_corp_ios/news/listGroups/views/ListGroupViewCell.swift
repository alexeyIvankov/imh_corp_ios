//
//  ListGroupViewCell.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 14/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class ListGroupViewCell : UITableViewCell, IListGroupViewCell {
    
    @IBOutlet weak var labelGroupName:UILabel!
    @IBOutlet weak var imageViewGroupActiveState:UIImageView!
    
    private var isActive = false
    
    func configure(group: INewsGroup) {
        self.labelGroupName.text = group.name
    }
    
    func getActiveState() -> Bool{
        return self.isActive
    }
    
    func setActiveState(active:Bool){
        self.isActive = active
        
        if self.isActive == true{
            self.imageViewGroupActiveState.image = UIImage(named: "arrow_accept")
        }
        else {
            self.imageViewGroupActiveState.image = nil
        }
    }
}
