//
//  INewsLoaderService.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 03/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

protocol INewsLoaderService {
    
    func addTransationToLoadBatchNews(completionBatch:@escaping ()->(),
                                      failedBatch: @escaping (NSError?)->())
    
    func isExecutingTransactions() -> Bool
    func cancelAllTransactions()
}
