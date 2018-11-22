//
//  LazyConfigutator.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 22/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class LazyParametersManager: ILazyParametersManager{
    
    private var storageLazyParametrs:[String:AnyObject]
    
    required init(){
        self.storageLazyParametrs = [:]
    }
    
    func addLazyParameter(parameter:AnyObject,
                          key:String,
                          receiver:AnyClass){
        let formatKey = self.createKey(key: key, receiver: receiver)
        self.storageLazyParametrs[formatKey] = parameter
    }
    
    func extractParamet(key:String, receiver:AnyClass) -> AnyObject?{
        let formatKey = self.createKey(key: key, receiver: receiver)
        let parameter = self.storageLazyParametrs[formatKey]
        self.storageLazyParametrs[formatKey] = nil
        
        return parameter
    }
    
    private func createKey(key:String, receiver:AnyClass) -> String{
        let receiverText = String(describing: receiver.self)
        let formatKey = receiverText + "$" + key
        
        return formatKey
    }
    
}
