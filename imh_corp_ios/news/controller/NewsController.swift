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
        self.tryShowCashedContent()
        self.loadNews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: Actions
    private func handleSelectCell(){
        self.limonade.setHandlerSelectCell { [unowned self] (model, cell, _, _)  in
            if let news = model as? INews{
                self.cake.router.handleSelect(news: news)
            }
        }
    }
    
    //MARK: - Data source
    private func tryShowCashedContent(){
        let group = self.cake.director.getGroup(name: "Пресса ПМХ")
        if group != nil {
            self.createOrUpdateDataSource(groups: [group!])
        }
    }
    
    private func loadNews(){
        
        self.cake.director.loadYammerGroups(success: { [unowned self] in
            let group = self.cake.director.getGroup(name: "Пресса ПМХ")
            if group != nil  && group?.groupId != nil{
                self.cake.director.loadYammerNews(groupId: group!.groupId!, success: {  [unowned self] in
                    self.createOrUpdateDataSource(groups: [group!])
                }, failed: { (error) in
                    
                })
            }

        }) { (error) in
            print(error)
        }
    }
    
    private func createOrUpdateDataSource(groups:[INewsGroup]){
        
        for group:INewsGroup in groups{
            self.limonade.appendSectionIfNeed(item: group, animation: UITableView.RowAnimation.bottom, header: "NewsSectionHeader")
            
            for news:INews in group.getNews(){
                self.limonade.tryAppendOrUpdateRow(rowItem: news,
                                                   sectionItem: group,
                                                   nameCell: "NewsCell",
                                                   animation: UITableView.RowAnimation.bottom)
            }
        }
    }
    
    //MARK - configure table view controlls
    private func configureTableViewComponents(){
        
        self.limonade?.setHandlerConfigureCell(handler: { (cell, model, nameRow, nameSection) in
            
            if let cell = cell as? INewsCell,
                let news = model as? INews{
                
                cell.configure(news: news)
            }
        })
        
        self.limonade.setHandlerConfigureHeader { (view, model) in
            
            if let header = view as? NewsSectionHeader,
                let group = model as? INewsGroup{
                header.set(text: group.name)
            }
        }
    }
}

