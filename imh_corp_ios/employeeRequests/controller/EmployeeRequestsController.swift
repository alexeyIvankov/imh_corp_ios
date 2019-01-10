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

class EmployeeRequestsController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Outlets
    @IBOutlet var tableView:UITableView!
    
    //MARK: Dependence
    var cake:IEmployeeRequestsCake = Depednence.tryInject()!
    
    //MARK:
    var categories:[IEmployeeRequestCategory]!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
        self.configureTableViewAndComponents()
        
        self.navigationItem.title = "Услуги"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.categories = self.cake.director.getFakeCategories()
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: - config ui components
    private func configureTableViewAndComponents(){
        self.tableView.estimatedRowHeight = UIScreen.main.bounds.size.height
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0);
        
        self.tableView.register(UINib(nibName:"EmployeeRequestCategoryCell", bundle:nil), forCellReuseIdentifier: "EmployeeRequestCategoryCell");
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category:IEmployeeRequestCategory = self.categories[indexPath.row]
        let cell:IEmployeeRequestCategoryCell = tableView.dequeueReusableCell(withIdentifier: "EmployeeRequestCategoryCell", for: indexPath) as! IEmployeeRequestCategoryCell
        
        cell.configure(category: category)
        
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let category:IEmployeeRequestCategory = self.categories[indexPath.row]
    }
}

