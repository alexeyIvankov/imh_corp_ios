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
    
    public var pageControll:FSPageControl?
    public var pageViewWillBeginDragging:Bool = false
    
    //MARK: IBOutlets
    @IBOutlet weak var viewContainerPagerView: UIView!{
        didSet{
            if viewContainerPagerView != nil{
                self.pagerView = FSPagerView(frame: self.viewContainerPagerView.bounds)
                self.pagerView?.translatesAutoresizingMaskIntoConstraints = false
                self.pagerView?.isInfinite = true
                self.viewContainerPagerView.addConstraints(self.createConstraints(pagerView: self.pagerView!))
                self.viewContainerPagerView.addSubview(self.pagerView!)
            }
        }
    }
    
    @IBOutlet weak var viewContainerPageControll: UIView!{
        didSet{
            if self.viewContainerPageControll != nil{
           
                self.pageControll = FSPageControl(frame: self.viewContainerPageControll.bounds)
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
    
    
    private var timerAutoChangePage:Timer?
    
    //MARK: Dependence
    var welcomeCake:IWelcomeCake = Depednence.tryInject()!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeCake.router.setOwnwer(ownwer: self)
        self.welcomeCake.design.apply(vc: self)
        
        self.configurePagesDataSource()
        self.registrerCells()
        
        self.navigationItem.title = " "
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pagerView?.reloadData()
        
        
        self.startAutoChangePage()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.stopAutoChangePage()
    }
    
    //MARK: User actions
    @IBAction func buttonStartPressed(_ sender: Any) {
        self.welcomeCake.router.handleTouchNextButton()
    }
    
    private func createConstraints(pagerView:FSPagerView) -> [NSLayoutConstraint]{
        
        let topConstraint = NSLayoutConstraint(item: pagerView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.viewContainerPagerView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: pagerView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.viewContainerPagerView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0)
        
        let leftConstraint = NSLayoutConstraint(item: pagerView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.viewContainerPagerView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
        
        let rightConstraint = NSLayoutConstraint(item: pagerView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.viewContainerPagerView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0)
        
        return [topConstraint, bottomConstraint, leftConstraint, rightConstraint]
    }
    
    //MARK: Data source
    private func configurePagesDataSource(){
        self.pages = self.welcomeCake.director.getPages()
    }
    
    private func registrerCells(){
        self.pagerView?.register(WelcomePagerCell.nibCell(), forCellWithReuseIdentifier: WelcomePagerCell.reuseIdCell())
    }
    
    
    //MARK: Switch page or image
    private func calculateNextPageAndChange(){
        
        guard self.pagerView != nil else {
            return
        }
        
        var nextIndexPage = 0
        
        if self.pagerView!.currentIndex < self.pages.count - 1{
            nextIndexPage = self.pagerView!.currentIndex + 1
        }

        self.pagerView?.scrollToItem(at: nextIndexPage, animated: true)
    }
    
    private func tryChangePageToPageControll(nextPage:Int){
        
        if self.pageControll!.currentPage != nextPage{
            self.pageControll!.currentPage = nextPage
        }
    }
    
    private func trySwitchPageOnThePageControll() {
        
        let collectionView:UICollectionView? = self.pagerView?.collectionView
        let visibleCell = collectionView?.visibleCells.first
        
        if visibleCell != nil {
            
            let indexPathCell = collectionView?.indexPath(for: visibleCell!)
            
            if indexPathCell != nil && self.pageControll!.currentPage != indexPathCell!.row {
                self.pageControll!.currentPage = indexPathCell!.row
            }
        }
    }
    
    
    //MARK:
    func startAutoChangePage(){
        self.timerAutoChangePage = Timer(timeInterval: 5, repeats: true, block: { [unowned self](timer) in
            self.calculateNextPageAndChange()
        })
        
        RunLoop.current.add(self.timerAutoChangePage!, forMode: RunLoop.Mode.default)
    }
    
    func stopAutoChangePage()
    {
        self.timerAutoChangePage?.invalidate()
        self.timerAutoChangePage = nil
    }
    
    func restartAutoChangePage(){
        self.stopAutoChangePage()
        self.startAutoChangePage()
    }
    
    //MARK: FSPagerViewDataSource
    func pagerView(_ pagerView: FSPagerView,
                   cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell:IWelcomePagerCell = pagerView.dequeueReusableCell(withReuseIdentifier:WelcomePagerCell.reuseIdCell(), at: index) as! IWelcomePagerCell
        
        let page = self.pages[index]
        cell.configure(page: page)
        
        if self.pageControll?.currentPage != index{
            self.pageControll?.currentPage = index
        }
        
        if let welcomeCell = cell as? WelcomePagerCell{
             self.welcomeCake.design.apply(cell:welcomeCell)
        }
        
        return cell as! FSPagerViewCell
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.pages.count
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        if let viewDisplayAnimation = cell as? IViewWithDisplayAnimation{
            if self.pageViewWillBeginDragging == false{
                viewDisplayAnimation.startDisplayAnimation()
            }
            
        }
        self.pageViewWillBeginDragging = false
    }
    
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int) {
        self.trySwitchPageOnThePageControll()
   
        if let viewDisplayAnimation = cell as? IViewWithDisplayAnimation{
            viewDisplayAnimation.stopDisplayAnimation()
        }
    }
    
    func pagerViewWillBeginDragging(_ pagerView: FSPagerView) {
        self.pageViewWillBeginDragging = true
        self.restartAutoChangePage()
    }
}


