//
//  FileDataStorage.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 11/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class FileDataStorage : IFileDataStorage {
  
    let db:IDataBase
    
    required init(db:IDataBase){
        self.db = db
    }
    
    func getNewsAttach(accountId: String,
                       newsId: String,
                       fileId: String,
                       completion: @escaping (IFile?) -> ()) {
        
        
        self.db.asynchFetch(type: FileRealm.self,
                            options: FetchOptionsPredicate(predicate:
                                NSPredicate(format: "newsId='\(newsId)' AND accountId='\(accountId)' AND fileId='\(fileId)'"), sortBy: nil),
                            completion: { (res, ctx) in
                                if let fileDb = res.first{
                                    
                                    let convertFile = File.createFile(file: fileDb)
                                    
                                    DispatchQueue.global().async {
                                        completion(convertFile)
                                    }
                                    
                                }
                                else {
                                    
                                    DispatchQueue.global().async {
                                        completion(nil)
                                    }
                                }
        })
    }
}
