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

class NewsController : UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView:UITableView!{
        didSet{
            self.limonade = Limonade(tableView: self.tableView)
        }
    }
        
    //MARK: Dependence
    var cake:INewsCake = Depednence.tryInject()!
    
    //MARK:
    private var limonade:Limonade!
    private let countDaysFromLoadNewsBatch = 15
    private let countMessagesFromNewsBatch = 50
    

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
        
        self.tableView.estimatedRowHeight = UIScreen.main.bounds.size.height
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.title = "Новости"
        self.configureTableViewComponents()
        self.handleSelectCell()
        self.setHandlersLimonade()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tryShowFirstBatchNewsPast(days: 15, countMessages: 50)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: Actions
    private func handleSelectCell(){
        self.limonade.setHandlerSelectCell { [unowned self] (model, cell, _, _)  in

            if let item = model as? ILimonadeItem{
                
                if let news = item.model as? INews{
                    self.cake.router.handleSelect(news: news)
                }
            }
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
            
        }
    }
    
    //MARK: - Data source
    private func createOrUpdateDataSource(news:[INews]){
        
        let rootSection = LimonadeItemTemplate(limonadeId: "root", limonadeSortKey: "root", hashLimonage: "root".hashValue)
        
        self.limonade.appendSectionIfNeed(item:rootSection,
                                          animation: UITableView.RowAnimation.automatic,
                                          sortType:.descending)
        
        for news:INews in news{
            
            let currentItem = LimonadeItemTemplate(limonadeId: news.newsId, limonadeSortKey: String(news.dateCreated), hashLimonage: news.body.hashValue, model:news)
            
            self.limonade.tryAppendOrUpdateRow(rowItem: currentItem,
                                               sectionItem: rootSection,
                                               nameCell: "NewsCell",
                                               animation: UITableView.RowAnimation.none)
        }
    }
    
    //MARK - configure table view controlls
    private func configureTableViewComponents(){
        
        self.limonade?.setHandlerCreateCellFoRow(handler: { (cell, model, nameRow, nameSection) in
            
            if let cell = cell as? INewsCell,
                let item = model as? ILimonadeItem{
                
                if let news = item.model as? INews{
                    cell.configure(news: news)
                }
            }
        })
    }
    
    private func setHandlersLimonade(){
        
        self.limonade?.setHandlerDidScrooll(handler: { (scrollView) in
            
            if scrollView.contentOffset.y > 0 &&
                scrollView.contentSize.height/scrollView.contentOffset.y < 2{
                let item = self.limonade.getLastModelRowIn(sectionId: "root")
                if let limonadeItem = item as? ILimonadeItem,
                    let news = limonadeItem.model as? INews{
                    self.truShowNextBatchFrom(news: news)
                }
                
            }
        })
    }
}

