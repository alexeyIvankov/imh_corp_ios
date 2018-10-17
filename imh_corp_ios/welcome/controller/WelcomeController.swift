//
//  WelcomeController.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 16.10.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class WelcomeController : UIViewController, FSPagerViewDelegate, FSPagerViewDataSource{
  
    private var pagerView:FSPagerView?{
        didSet{
            self.pagerView?.delegate = self
            self.pagerView?.dataSource = self
        }
    }
    
    private var pageControll:FSPageControl?
    
    //MARK: IBOutlets
    @IBOutlet weak var viewContainerPagerView: UIView!{
        didSet{
            if viewContainerPagerView != nil{
                self.pagerView = FSPagerView(frame: self.viewContainerPagerView.bounds)
                self.viewContainerPagerView.addSubview(self.pagerView!)
            }
        }
    }
    
    @IBOutlet weak var viewContainerPageControll: UIView!{
        didSet{
            if self.viewContainerPageControll != nil{
                self.pageControll = FSPageControl(frame: self.viewContainerPageControll.bounds)
                self.pageControll?.configureToWelcomeScreen()
                self.viewContainerPageControll.addSubview(self.pageControll!)
            }
        }
    }
    @IBOutlet weak var viewContainerStartButton: UIView!
    
    @IBOutlet weak var buttonStart: UIButton!
    
    private var pages:[IWelcomePage]!{
        didSet{
            if self.pages != nil{
               self.pageControll?.numberOfPages = self.pages.count
            }
            else {
                self.pageControll?.numberOfPages  = 0
            }
            
        }
    }
    
    //MARK: Dependence
    var welcomeCake:IWelcomeCake = Depednence.tryInject()!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeCake.router.setOwnwer(ownwer: self)
        self.welcomeCake.design.apply(vc: self)
        
        self.configurePagesDataSource()
        self.registrerCells()
        self.pagerView?.reloadData()
    }
    
    //MARK: User actions
    @IBAction func buttonStartPressed(_ sender: Any) {
    
    }
    
    private func configurePagesDataSource(){
        self.pages = self.welcomeCake.director.getPages()
    }
    
    private func registrerCells(){
        self.pagerView?.register(WelcomePagerCell.nibCell(), forCellWithReuseIdentifier: WelcomePagerCell.reuseIdCell())
    }
    
    //MARK: FSPagerViewDataSource
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell:IWelcomePagerCell = pagerView.dequeueReusableCell(withReuseIdentifier:WelcomePagerCell.reuseIdCell(), at: index) as! IWelcomePagerCell
        let page = self.pages[index]
        cell.configure(page: page)
        
        return cell as! FSPagerViewCell
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.pages.count
    }
}

extension FSPageControl{
    func configureToWelcomeScreen(){
        self.itemSpacing = 8
        self.interitemSpacing = 10
        self.contentHorizontalAlignment = .center
        self.hidesForSinglePage = true
        self.setFillColor(UIColor(r:255, g:255, b:255, alpha:0.2), for: UIControl.State.normal)
        self.setFillColor(UIColor.white, for: UIControl.State.selected)
    }
}
