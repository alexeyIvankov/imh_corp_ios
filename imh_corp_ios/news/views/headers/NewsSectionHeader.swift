//
//  ProfileMainHeaderTable.swift
//  LemoLink
//
//  Created by Alexey Ivankov on 03.03.2018.
//  Copyright © 2018 Business Technology. All rights reserved.
//

import Foundation
import UIKit

class NewsSectionHeader : UIView  {
  
    @IBOutlet var labelTitle:UILabel!
    
    func set(text: String) {
        self.labelTitle.text = text
    }
}
