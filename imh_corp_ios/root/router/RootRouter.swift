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
    var pmhLoader:IPMHLoader
    
    required init(loaderService:ILoaderService,
                  pmhLoader:IPMHLoader){
        self.loaderService = loaderService
        self.pmhLoader = pmhLoader
    }

    func setOwnwer(ownwer: UIViewController) {
        
        guard  let root = ownwer as? RootController else {
            fatalError("failed type owner")
        }
        self.owner = root
    }
    
    func showPMHLoader(){
        self.pmhLoader.show()
    }
    
    func hidePMHLoader(){
        self.pmhLoader.hide()
    }
}
