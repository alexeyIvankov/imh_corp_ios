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
    
    func executeRPCRequest(url:URLConvertible,
                           method:String,
                           params:[String: Any],
                           success:@escaping (RPCResponce)->(),
                           failed: @escaping (NSError)->())
    
    func setHandleAllResponce(handler:@escaping (RPCResponce)->())
    func setHandleAllError(handler:@escaping (NSError)->())
}
