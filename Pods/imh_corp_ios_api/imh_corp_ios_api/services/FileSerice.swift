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
                      queue:DispatchQueue,
                      success:@escaping (Data)->(),
                      failed:@escaping (NSError)->()){
        
        Alamofire.request(url).downloadProgress(closure: progress).responseData { (responce) in
            
            if responce.data != nil && responce.error == nil {
                success(responce.data!)
            }
            else {
                
                if responce.error != nil {
                    failed(NSError(domain: responce.error!.localizedDescription, code: -1, userInfo: nil))
                }
                else {
                    failed(NSError(domain: "failed download", code: -1, userInfo: nil))
                }
            }
        }
    }
}
