//
//  NewsDetailsDesign.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class ListGroupsNewsDesign : IListGroupsNewsDesign {
    
    required init(appDesign: IAppDesign) {
        
    }
    
    func apply<T>(vc: T) where T : UIViewController {
        
        guard let newsDetailsVC = vc as? ListGroupsNewsController else {
            return
        }
        
    }
    
}
