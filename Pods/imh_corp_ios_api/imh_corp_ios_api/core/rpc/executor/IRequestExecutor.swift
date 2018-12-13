//
//  IRequestExecutor.swift
//  neon_api
//
//  Created by Alexey Ivankov on 28.04.2018.
//  Copyright © 2018 Norvik Bank. All rights reserved.
//

import Foundation
import Alamofire

public protocol IRequestExecutor {
    
    func createRPCRequest(url:URLConvertible,
                          method:String,
                          params:[String: Any]) -> DataRequest
}
