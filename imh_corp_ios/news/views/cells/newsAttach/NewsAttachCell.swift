//
//  NewsAttachCell.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 10/12/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class NewsAttachCell : UITableViewCell,  INewsAttachCell{
    
    @IBOutlet weak var labelTitleNews:UILabel!
    @IBOutlet weak var labelSubTitleNews:UILabel!
    @IBOutlet weak var labelGroupName:UILabel!
    @IBOutlet weak var labelDateCreated:UILabel!
    @IBOutlet weak var imageViewAttach:UIImageView!
    
    private var fileDirector:IFileDirector!
    private var news:INews!
    
    var dateFormaterConverter:DateFormatter {
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formater
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addTopContentInset()
    }
    
    func setFileDirector(fileDirector:IFileDirector){
        self.fileDirector = fileDirector
    }
    
    func configure(news: INews) {
        
        self.labelTitleNews.text = news.body
        self.labelSubTitleNews.text = news.body
        self.labelGroupName.text = "#" + news.groupName
        
        let date = Date.init(timeIntervalSince1970: TimeInterval(news.dateCreated))
        self.labelDateCreated.text = self.dateFormaterConverter.string(from:date)
        
        if self.news == nil{
            self.news = news
            self.tryShowPreviewFirstAttach()
        }
        else {
            if self.news.newsId != news.newsId{
                self.news = news
                self.clearPreviewImage()
                self.tryShowPreviewFirstAttach()
            }
        }
    }
    
    private func clearPreviewImage(){
        self.imageViewAttach.image = nil
    }
    
    private func addTopContentInset(){
        let frameContentView = contentView.frame
        let correctFrame = frameContentView.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0))
        contentView.frame = correctFrame
    }
    
    private func tryShowPreviewFirstAttach(){
        
        guard self.news != nil else {
            return
        }
        
        self.trySearchPreviewAttach { (imageAttach) in
            
            guard imageAttach != nil else {
                return
            }
            
            self.fileDirector.giveMeFile(operationId: self.news.newsId,
                                         typeFile: TypeFileRequest.newsPreview(newsId: imageAttach!.newsId, fileId:imageAttach!.fileId),
                                         success: { (data, operationId) in
                
                guard self.news != nil &&  self.news.newsId == operationId else {
                    return
                }
                
                let image = UIImage(data: data)
                
                DispatchQueue.main.async(execute: {
                    
                    if image != self.imageViewAttach.image{
                         self.imageViewAttach.image = image
                    }
                   
                })
                
            }, failed: { (error, operationId) in
                
            }, startLoad: nil, endLoad: nil, progressLoad: nil)
        }
    }
    
    private func trySearchPreviewAttach(completion: @escaping(IFile?)->()){
        
        let attaches = Array(self.news.attaches)
        
        DispatchQueue.global().async {
            
            var imageAttach:IFile?
            
            for attach in attaches{
                if attach.type == FileType.image.rawValue{
                    imageAttach = attach
                    break
                }
            }
            completion(imageAttach)
        }
    }
}
