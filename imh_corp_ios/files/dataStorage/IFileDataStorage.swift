//
//  IFileDataStorage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 11/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

public protocol IFileDataStorage : AnyObject{
    
    func getNewsAttach(accountId:String,
                              newsId:String,
                              fileId:String,
                              completion: @escaping(IFile?)->())
}
