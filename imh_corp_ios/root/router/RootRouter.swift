//
//  RootRouter.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 30.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class RootRouter : IRootRouter {
   
    weak var owner: UIViewController?
    var loaderService:ILoaderService
    
    required init(loaderService:ILoaderService){
        self.loaderService = loaderService
    }

    func setOwnwer(ownwer: UIViewController) {
        
        guard  let root = ownwer as? RootController else {
            fatalError("failed type owner")
        }
        self.owner = root
    }
}
