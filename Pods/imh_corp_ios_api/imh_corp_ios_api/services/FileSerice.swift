//
//  FileSerice.swift
//  imh_corp_ios_api
//
//  Created by Alexey Ivankov on 03/12/2018.
//  Copyright © 2018 personal. All rights reserved.
//

import Foundation
import Alamofire

class FileSerice: IFileService {
 
  
    func downloadFile(url:String,
                      progress:@escaping (Progress)->(),
                      success:@escaping (Data)->(),
                      failed:@escaping (NSError)->()){
        
        Alamofire.request(url).downloadProgress(closure : { (progress) in
            print(progress.fractionCompleted)
            
        }).responseData{ (response) in
            
            switch response.result {
                
            case .success(let value): do {
                success(value)
            }
                
            case .failure(let error): do{
                failed(NSError(domain: error.localizedDescription, code: -1, userInfo: nil))
                }
                
            }
        }
    }
}
