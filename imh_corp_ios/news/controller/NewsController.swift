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
        
        self.navigationItem.title = "Новости"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadNews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func loadNews(){
        
        self.cake.director.loadYammerGroups(success: { [unowned self] in
            let group = self.cake.director.getGroup(name: "Пресса ПМХ")
            if group != nil  && group?.groupId != nil{
                self.cake.director.loadYammerNews(groupId: group!.groupId!, success: {  [unowned self] in
                    let news = self.cake.director.getNews(groupName: "Пресса ПМХ")
                    print(news)
                }, failed: { (error) in
                    
                })
            }

        }) { (error) in
            print(error)
        }
        
    }
    
//    //MARK: - Data source
//    private func configureDataSourceCompanys(){
//
//        self.companysList = self.cake.serviceLayer.getListCompanys()
//        self.limonade.appendSection(name: "root")
//
//        if companysList != nil {
//
//            for company in self.companysList!{
//                self.limonade.appendRow(name: company.name, data: company as AnyObject, nameCell: "CompanyCell", nameSection: "root")
//            }
//        }
//    }
//
//    private func configureTableViewComponents(){
//
//        self.limonade?.setHandlerConfigureCell(handler: { (cell, model, nameRow, nameSection) in
//
//            if let cell = cell as? ICompanyCell,
//                let company = model as? ICompany{
//
//                cell.configure(company: company)
//
//                if self.selectedCompany != nil && self.selectedCompany!.name == company.name{
//                    cell.setSelected(selected: true)
//                }
//                else{
//                    cell.setSelected(selected: false)
//                }
//            }
//        })
//
//        self.limonade.setHandlerSelectCell(handler: { (model, cell, nameRow, nameSection) in
//
//            if let company = model as? ICompany, let companyCell = cell as? ICompanyCell{
//
//                self.deleselectAll()
//                companyCell.setSelected(selected: true)
//                self.selectedCompany = company
//                self.cake.serviceLayer.save(company: company)
//
//                print(company)
//            }
//        })
//    }
//
//    private func deleselectAll(){
//        let cells = self.limonade.getVisibleCells()
//        for cell in cells{
//            if let companyCell = cell as? ICompanyCell{
//                companyCell.setSelected(selected: false)
//            }
//        }
//    }
}

