//
//  IError.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 25/10/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol IError : AnyObject {
    func message() -> String
}

extension NSError : IError{
    
    func message() -> String {
        return self.domain
    }
}
