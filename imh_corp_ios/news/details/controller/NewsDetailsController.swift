//
//  NewsDetailsController.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class NewsDetailsController : UIViewController{
    
    //MARK: Dependence
    var cake:INewsDetailsCake = Depednence.tryInject()!
    
    //MARK: IBOutlets
    @IBOutlet weak var labelNewsTitle:UILabel!
    @IBOutlet weak var labelNewsBody:UILabel!
    
    //MARK:
    public var news:INews!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
        self.configureContent()
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
}
