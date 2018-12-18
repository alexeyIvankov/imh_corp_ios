//
//  UINavigationConroller+BarButtons.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 14/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func addRightBarRutton(title:String?,
                           style: UIBarButtonItem.Style,
                           handler: @escaping()->()) -> ActionHandler?{
        
        let handler = ActionHandler(handler: handler)
        
        let button = UIBarButtonItem(title: title,
                                     style: style,
                                     target: handler,
                                     action: #selector(handler.hanbleBarButtonAction))
        
        self.addRightBarButton(button: button)
        
        return handler
    }
    
    func addRightBarRutton(image:UIImage?,
                           style: UIBarButtonItem.Style,
                           handler: @escaping()->()) -> ActionHandler?{
        
        let handler = ActionHandler(handler: handler)
        
        let button = UIBarButtonItem(image: image,
                                     style: style,
                                     target: handler,
                                     action: #selector(handler.hanbleBarButtonAction))
        
        self.addRightBarButton(button: button)
        
        return handler
    }
    
    func addLeftBarRutton(title:String?,
                          style: UIBarButtonItem.Style,
                          handler: @escaping()->()) -> ActionHandler?{
        
        let handler = ActionHandler(handler: handler)
        
        let button = UIBarButtonItem(title: title,
                                     style: style,
                                     target: handler,
                                     action: #selector(handler.hanbleBarButtonAction))
        
        self.addLeftBarButton(button: button)
        
        return handler
    }
    
    func addLeftBarRutton(image:UIImage?,
                          style: UIBarButtonItem.Style,
                          handler: @escaping()->()) -> ActionHandler?{
        
        let handler = ActionHandler(handler: handler)
        
        let button = UIBarButtonItem(image: image,
                                     style: style,
                                     target: handler,
                                     action: #selector(handler.hanbleBarButtonAction))
        
        self.addLeftBarButton(button: button)
        
        return handler
    }
    
    private func addRightBarButton(button:UIBarButtonItem){
        
        if self.navigationBar.topItem?.rightBarButtonItems == nil{
            self.navigationBar.topItem?.rightBarButtonItems  = []
        }
         self.navigationBar.topItem?.rightBarButtonItems?.append(button)
    }
    
    private func addLeftBarButton(button:UIBarButtonItem){
        
        if self.navigationBar.topItem?.leftBarButtonItems == nil{
            self.navigationBar.topItem?.leftBarButtonItems  = []
        }
        self.navigationBar.topItem?.leftBarButtonItems?.append(button)
    }
}

final class ActionHandler : NSObject {
    
    var handler: ()->()
    
    init(handler: @escaping()->()){
        self.handler = handler
        super.init()
    }
    
    @objc public func hanbleBarButtonAction(){
        handler()
    }
}
