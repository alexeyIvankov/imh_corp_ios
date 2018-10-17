//
//  String+Remove.swift
//  Neon
//
//  Created by Alexey Ivankov on 25.04.2018.
//  Copyright © 2018 Norvik Bank. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    func removeLastCharacter() -> String{
        return self.substring(to: self.index(before: self.endIndex))
    }
}
