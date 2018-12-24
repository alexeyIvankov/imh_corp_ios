//
//  NewsDetailsController.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 27/11/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class ListGroupsNewsController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //MARK: Dependence
    var cake:IListGroupsNewsCake = Depednence.tryInject()!
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView:UITableView!
    
    //MARK:
    private var actionDoneButton:ActionHandler?
    private var actionSelectButton:ActionHandler?
    private var groupList:[INewsGroup] = [INewsGroup]()
    private var idListHidenGroups:[String] = [String]()
    private let queueUpdateTableDataSource = DispatchQueue(label: "NewsController.queue")
    
    //MARK: Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
        self.configureTableViewAndComponents()
        self.createAndHandleBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.idListHidenGroups = self.cake.director.serviceGroups.getIdListGroupsOff()
        
        self.tryShowGroups()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: Config ui components
    private func configureTableViewAndComponents(){
        self.tableView.estimatedRowHeight = UIScreen.main.bounds.size.height
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0);
        
        self.tableView.register(UINib(nibName:"ListGroupViewCell", bundle:nil), forCellReuseIdentifier: "ListGroupViewCell");
    }
    
    private func createAndHandleBarButtons(){
        
        self.actionDoneButton =
            self.addRightBarRuttonToNavigationBar(title: "Готово",
                                                  handler: { [weak self] in
                                                    
                                                    let strongSelf = self
                                                    
                                                    if strongSelf != nil{
                                                        strongSelf!.cake.director.serviceGroups.saveIdListGroupsOff(idList: strongSelf!.idListHidenGroups)
                                                        strongSelf!.cake.router.handleTouchDoneButton()
                                                    }
                                                    
            })
        
        self.actionSelectButton =
            self.addLeftBarRuttonToNavigationBar(title: "Снять/Выбрать все",
                                                 handler: { [weak self] in
                                                    
                                                    let strongSelf = self
                                                    
                                                    if strongSelf != nil{
                                                        
                                                        if strongSelf?.idListHidenGroups.count == 0{
                                                            strongSelf!.selectAllGroups()
                                                        }
                                                        else {
                                                            strongSelf!.deselectAllGroups()
                                                        }
                                                        
                                                    }
            })
        
    }
    
    //MARK: data source and load data
    private func tryShowGroups(){
        
        self.cake
            .director
            .serviceGroups
            .getMeAllGroups(oldCashedGroups: { (oldGroups) in
                
                DispatchQueue.main.async {
                    self.createOrUpdateDataSource(groups: oldGroups)
                }
                
            }, newLoadedGroups: { (loadedGroups) in
                
                DispatchQueue.main.async {
                    self.createOrUpdateDataSource(groups: loadedGroups)
                }
                
            }) { (error) in
                print(error)
        }
    }
    
    private func createOrUpdateDataSource(groups:[INewsGroup]){
        
        guard groups.count > 0 else{
            return
        }
        
        self.queueUpdateTableDataSource.async {
            
            var copyGroupsList = Array(self.groupList)
            var isAddededGroups = false
            
            for currentGroup in groups{
                
                if copyGroupsList.contains(where: { (group) -> Bool in
                    if currentGroup.groupId == group.groupId{
                        return true
                    }
                    else {
                        return false
                    }
                }) == false{
                    copyGroupsList.append(currentGroup)
                    isAddededGroups = true
                }
            }
            
           
            DispatchQueue.main.async {
                
                if isAddededGroups {
                    self.groupList = copyGroupsList
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: select/deselect groups
    private func selectAllGroups(){
        for group in self.groupList{
            if self.idListHidenGroups.contains(group.groupId) == false{
                self.idListHidenGroups.append(group.groupId)
            }
        }
        self.tableView.reloadData()
    }
    
    private func deselectAllGroups(){
        self.idListHidenGroups.removeAll()
        self.tableView.reloadData()
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let group:INewsGroup = self.groupList[indexPath.row]
        let cell:IListGroupViewCell =  tableView.dequeueReusableCell(withIdentifier: "ListGroupViewCell", for: indexPath) as! IListGroupViewCell
        cell.configure(group: group)
        
        if self.idListHidenGroups.contains(group.groupId) {
            cell.setActiveState(active: false)
        }
        else {
            cell.setActiveState(active: true)
        }
    
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let group:INewsGroup = self.groupList[indexPath.row]
        
        if self.idListHidenGroups.contains(group.groupId){
            self.idListHidenGroups.removeAll { (item) -> Bool in
                
                if item == group.groupId {
                    return true
                }
                else {
                    return false
                }
            }
        }
        else {
            self.idListHidenGroups.append(group.groupId)
        }
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
