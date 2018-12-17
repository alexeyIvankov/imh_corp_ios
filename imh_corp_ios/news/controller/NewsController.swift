//
//  LoginController.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import KeyboardHandler

class NewsController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView:UITableView!
        
    //MARK: Dependence
    var cake:INewsCake = Depednence.tryInject()!
    
    //MARK:
    private var newsList:[INews] = [INews]()
    private var listIdGroupOff:[String] = [String]()
    private let countMessagesFromNewsBatch = 50
    private let queueUpdateTableDataSource = DispatchQueue(label: "NewsController.queue")
    
    private var actionFilterButton:ActionHandler?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
        
        self.configureTableViewAndComponents()
        self.navigationItem.title = "Новости"
        
        self.actionFilterButton = self.addRightBarRuttonToNavigationBar(image: UIImage(named: "filter"), handler: { [weak self] in
        
            self?.cake.router.handleTouchFilterButton()
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.selectBehaviorShowNews()
        self.loadGroupsNews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func selectBehaviorShowNews(){
        
        let listIdGroupOff = self.cake.director.serviceGroups.getIdListGroupsOff()
        
        if listIdGroupOff != self.listIdGroupOff{
            self.listIdGroupOff = listIdGroupOff
            reloadAllNews()
        }
        else {
            self.listIdGroupOff = listIdGroupOff
            updateFirstBatchNews()
        }
    }
    
    
    private func reloadAllNews(){
        self.newsList.removeAll()
        self.tableView.reloadData()
        self.tryShowFirstBatchNewsPast(days: 15, countMessages: 50)
    }
    
    private func updateFirstBatchNews(){
         self.tryShowFirstBatchNewsPast(days: 15, countMessages: 50)
    }
    
    private func configureTableViewAndComponents(){
        self.tableView.estimatedRowHeight = UIScreen.main.bounds.size.height
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName:"NewsCell", bundle:nil), forCellReuseIdentifier: "NewsCell");
        self.tableView.register(UINib(nibName:"NewsAttachCell", bundle:nil), forCellReuseIdentifier: "NewsAttachCell");
    }
    
    //MARK: - load groups
    private func loadGroupsNews(){
        self.cake.director.serviceGroups.updateGroups { (error) in
            print(error)
        }
    }
    
    //MARK: - load news
    private func tryShowFirstBatchNewsPast(days:Int, countMessages:Int){
        
        let today = Date()
        let calculateDate = Calendar.current.date(byAdding: .day, value: -days, to: today)?.timeIntervalSince1970.rounded()
        if calculateDate != nil{
            self.tryShowNews(startDate: Int(calculateDate!), endDate: nil, count: countMessages)
        }
    }
    
    private func truShowNextBatchFrom(news:INews){
        let date = Date(timeIntervalSince1970: TimeInterval(news.dateCreated))
        self.tryShowNews(startDate: nil, endDate: Int(date.timeIntervalSince1970.rounded()), count: self.countMessagesFromNewsBatch)
    }
    
    private func tryShowNews(startDate:Int?,
                             endDate:Int?,
                             count:Int){
        
        guard self.cake.director.serviceNews.getState() == .ready else{
            return
        }
        
        
        self.cake.director.serviceNews.giveMeYammerNews(startDate: startDate,
                                                        endDate: endDate,
                                                        count: count,
                                                        oldCashedNews: { (cashedNews) in
                                                            
                                                DispatchQueue.main.async {
                                                    self.createOrUpdateDataSource(news: cashedNews)
                                                }
            
        }, newLoadedNews: { (newLoadedNews) in
            
            DispatchQueue.main.async {
                self.createOrUpdateDataSource(news: newLoadedNews)
            }
            
        }) { (error) in
            print(error)
        }
    }
    
    //MARK: - Data source
    private func createOrUpdateDataSource(news:[INews]){
        
        guard news.count > 0 else{
            return
        }
        
        
        self.queueUpdateTableDataSource.async {
            
            var copyNewsList = Array(self.newsList)
             var isAddededNews = false
            
            for currentNews in news{
             
                if copyNewsList.contains(where: { (news) -> Bool in
                    if currentNews.newsId == news.newsId{
                        return true
                    }
                    else {
                        return false
                    }
                }) == false{
                   
                    if self.listIdGroupOff.contains(currentNews.groupId) == false{
                         isAddededNews = true
                        copyNewsList.append(currentNews)
                    }
                }
            }
            
            
            let sortedList = copyNewsList.sorted { (new1, new2) -> Bool in
                if new1.dateCreated > new2.dateCreated{
                    return true
                }
                else {
                    return false
                }
            }
            
            
            DispatchQueue.main.async {
                if isAddededNews {
                    self.newsList = sortedList
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let news:INews = self.newsList[indexPath.row]
        var cell:INewsPresenter!
        
        if news.containsImages == true{
            cell = tableView.dequeueReusableCell(withIdentifier: "NewsAttachCell", for: indexPath) as? INewsPresenter
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? INewsPresenter
        }
        
        if let attachCell = cell as? INewsAttachCell{
            attachCell.setFileDirector(fileDirector: self.cake.director.fileDirector)
        }
        
        cell.configure(news: news)
        
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let news:INews = self.newsList[indexPath.row]
        self.cake.router.handleSelect(news: news)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 0 &&
            scrollView.contentSize.height/scrollView.contentOffset.y < 2{
            let news = self.newsList.last
            if news != nil{
                self.truShowNextBatchFrom(news: news!)
            }
        }
    }
}

