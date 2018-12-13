//
//  IFileDirector.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 11/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public enum TypeFileRequest{
    case newsAttach(newsId:String, fileId:String)
    case newsPreview(newsId:String, fileId:String)
}

protocol IFileDirector : AnyObject {
    
    func giveMeFile(operationId:String,
                    typeFile:TypeFileRequest,
                    success: @escaping (Data, String)->(),
                    failed:@escaping  (NSError, String)->(),
                    startLoad:(()->())?,
                    endLoad:(()->())?,
                    progressLoad:((Float)->())?)
}
