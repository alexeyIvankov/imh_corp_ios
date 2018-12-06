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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNewsPast(days: 15, countMessages: 25)
        
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
    
    
    //MARK: - Data source
    private func showNewsPast(days:Int, countMessages:Int){
        
        let today = Date()
        let calculateDate = Calendar.current.date(byAdding: .day, value: -days, to: today)?.timeIntervalSince1970.rounded()
        if calculateDate != nil{
            self.showNews(startDate: Int(calculateDate!), count: countMessages)
        }
        
    }
    
    private func showNews(startDate:Int, count:Int){
        self.cake.director.giveMeYammerNews(startDate: startDate, count: count, success: { (news) in
            
            DispatchQueue.main.async {
                self.createOrUpdateDataSource(news: news)
            }
            
        }) { (eror) in
            
        }
    }
    
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
        
        self.limonade?.setHandlerConfigureCell(handler: { (cell, model, nameRow, nameSection) in
            
            if let cell = cell as? INewsCell,
                let item = model as? ILimonadeItem{
                
                if let news = item.model as? INews{
                    cell.configure(news: news)
                }
                
            }
        })
    }
}

