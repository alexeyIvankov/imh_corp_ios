//
//  UIViewController+BarButtons.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 14/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func addRightBarRuttonToNavigationBar(title:String?,
                           style: UIBarButtonItem.Style = .plain,
                           handler: @escaping()->()) -> ActionHandler?{
        
        return self.navigationController?.addRightBarRutton(title: title, style: style, handler: handler)
    }
    
   
    func addRightBarRuttonToNavigationBar(image:UIImage?,
                           style: UIBarButtonItem.Style = .plain,
                           handler: @escaping()->()) -> ActionHandler?{
        return self.navigationController?.addRightBarRutton(image: image, style: style, handler: handler)
    }
    
    
    func addLeftBarRuttonToNavigationBar(title:String?,
                                         style: UIBarButtonItem.Style = .plain,
                                         handler: @escaping()->()) -> ActionHandler?{
        
        return self.navigationController?.addLeftBarRutton(title: title, style: style, handler: handler)
    }
    
    func addLeftBarRuttonToNavigationBar(image:UIImage?,
                                         style: UIBarButtonItem.Style = .plain,
                                         handler: @escaping()->()) -> ActionHandler?{
        return self.navigationController?.addLeftBarRutton(image: image, style: style, handler: handler)
    }
}
