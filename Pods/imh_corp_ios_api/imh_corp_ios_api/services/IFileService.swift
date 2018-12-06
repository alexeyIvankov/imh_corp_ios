//
//  IFileService.swift
//  imh_corp_ios_api
//
//  Created by Alexey Ivankov on 03/12/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation

public protocol IFileService : AnyObject {
    
    func downloadFile(url:String,
                      progress:@escaping (Progress)->(),
                      queue:DispatchQueue,
                      success:@escaping (Data)->(),
                      failed:@escaping (NSError)->())
}
