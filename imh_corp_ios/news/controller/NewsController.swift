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
        self.cake.director.cancelLoadloadYammerNewsToAvailableGroups()
        self.loadOrUpdateContent()
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
        self.cake.director.getYammerNews { (news) in
            DispatchQueue.main.async {
                self.createOrUpdateDataSource(news: news)
            }
        }
    }
    
    private func loadNews(){
        
        self.cake.director.loadAllYammerGroups(success: { [unowned self] in
            
            self.cake.director.getYammerGroup(name: "Обучение") { (group) in

                if group != nil  && group?.groupId != nil{
                    let groupId = group!.groupId

                    self.cake.director.loadYammerNews(groupId: groupId!, lastMessageId: nil, success: {  [unowned self] in
                        self.tryShowCashedContent()
                        }, failed: { (error) in
                            print(error)
                    })
                }
            }

        }) { (error) in
            print(error)
        }
    }
    
    private func loadOrUpdateContent(){
        
        self.cake.director.loadAllYammerGroups(success: { [unowned self] in
            self.cake.director.addAllYammerGroupsToAvailableList { [unowned self] in
                
                self.cake.director.loadYammerNewsToAvailableGroups(success: {
                    print("sucess")
                    self.tryShowCashedContent()
                }, failed: { (error) in
                    print("failed")
                })
            }
            
        }) { (error) in
            
        }
    }
    
    private func createOrUpdateDataSource(groups:[INewsGroup]){
        
        self.limonade.appendSectionIfNeed(item: LimonadeItemTemplate(value: "root"),
                                          animation: UITableView.RowAnimation.bottom,
                                          sortType:.descending)
        
        for group:INewsGroup in groups{
            
            for news:INews in group.getNews(){
                self.limonade.tryAppendOrUpdateRow(rowItem: news,
                                                   sectionItem: LimonadeItemTemplate(value: "root"),
                                                   nameCell: "NewsCell",
                                                   animation: UITableView.RowAnimation.bottom)
            }
        }
    }
    
    private func createOrUpdateDataSource(news:[INews]){
        
        self.limonade.appendSectionIfNeed(item: LimonadeItemTemplate(value: "root"),
                                          animation: UITableView.RowAnimation.automatic,
                                          sortType:.descending)
        
        for news:INews in news{
            self.limonade.tryAppendOrUpdateRow(rowItem: news,
                                               sectionItem: LimonadeItemTemplate(value: "root"),
                                               nameCell: "NewsCell",
                                               animation: UITableView.RowAnimation.none)
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

