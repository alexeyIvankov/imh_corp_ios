//
//  NewsDetailsController.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit
import ImageSlideshow

class NewsDetailsController : UIViewController{
    
    enum NewsDetailControllerState{
        case showAttachAndText
        case showOnlyText
    }
    
    //MARK: Dependence
    var cake:INewsDetailsCake = Depednence.tryInject()!
    
    //MARK: IBOutlets
    @IBOutlet weak var labelNewsTitle:UILabel!
    @IBOutlet weak var labelNewsBody:UILabel!
    
    @IBOutlet weak var viewAttachContainer:UIView!
    @IBOutlet weak var heightAttachContainerConstraint:NSLayoutConstraint!
    @IBOutlet weak var viewImageSlideshow:ImageSlideshow!
    
    //MARK:
    public var news:INews!
    public var imageAttaches:[IFile] = []
    private var stateEngine:StateEngine<NewsDetailControllerState> = StateEngine<NewsDetailControllerState>()
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if news == nil{ fatalError("news no set") }
        
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
        self.configureContent()
        
        self.configureStates()
        self.selectState()
        
        if self.imageAttaches.count > 0{
            self.configureSlider()
            self.configureSliderImagesDataSource()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK:
    private func configureContent(){
        self.labelNewsTitle.text = self.news.body
        self.labelNewsBody.text = self.news.body
    }
    
    private func configureSlider(){
        self.viewImageSlideshow.pageIndicator = LabelPageIndicator()
        self.viewImageSlideshow.activityIndicator = DefaultActivityIndicator()
    }
    
    //MARK: Data Source
    private func configureSliderImagesDataSource(){
        
        var sliderImagesDataSource:[InputSource] = [InputSource]()
        
        for file in self.imageAttaches{
            let dataSource = NewsAttachDataSource(file: file, newsId: self.news.newsId, fileDirector: self.cake.director.fileDirector)
            sliderImagesDataSource.append(dataSource)
        }
        self.viewImageSlideshow.setImageInputs(sliderImagesDataSource)
    }
    
    //MARK:States
    private func selectState(){
        
        for file in self.news.attaches{
            
            if file.type == "image"{
                self.imageAttaches.append(file)
            }
        }
        
        if self.imageAttaches.count > 0 {
            self.stateEngine.changeState(type: NewsDetailsController.NewsDetailControllerState.showAttachAndText)
        }
        else {
             self.stateEngine.changeState(type: NewsDetailsController.NewsDetailControllerState.showOnlyText)
        }
    }
    
    private func configureStates(){
        
        self.stateEngine.addState(type: NewsDetailsController.NewsDetailControllerState.showOnlyText) { (data) in
            
            self.viewAttachContainer.isHidden = true
            self.heightAttachContainerConstraint.constant = 0
        }
        
        self.stateEngine.addState(type: NewsDetailsController.NewsDetailControllerState.showAttachAndText) { (data) in
            
            self.viewAttachContainer.isHidden = false
            self.heightAttachContainerConstraint.constant = 250
        }
    }
}
