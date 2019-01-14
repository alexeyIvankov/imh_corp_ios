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

class EventsController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Dependence
    var cake:IEventsCake = Depednence.tryInject()!
    
    //MARK: IBOutlets
    @IBOutlet var buttonTodayEvents:UIButton!
    @IBOutlet var buttonAllEvents:UIButton!
    @IBOutlet var tableView:UITableView!
    
    //MARK:
    var events:[[IEvent]] = []
    

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
        self.configureTableViewAndComponents()
        events.append(self.cake.director.eventService.getFakeEventsToday())
        
        self.navigationItem.title = "События"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: Actions
    @IBAction func buttonTodayEventsPressed(){
        self.buttonTodayEvents.isSelected = true
        self.buttonAllEvents.isSelected = false
        self.changeTab()
    }
    
    @IBAction func buttonAllEventsPressed(){        
        self.buttonTodayEvents.isSelected = false
        self.buttonAllEvents.isSelected = true
        self.changeTab()
    }
    
    //MARK: - config ui components
    private func configureTableViewAndComponents(){
        self.tableView.estimatedRowHeight = UIScreen.main.bounds.size.height
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0);
        
        self.tableView.register(UINib(nibName:"EventCell", bundle:nil), forCellReuseIdentifier: "EventCell");
    }
    
    private func changeTab(){
         self.events.removeAll()
        
        if self.buttonTodayEvents.isSelected == true{
            events.append(self.cake.director.eventService.getFakeEventsToday())
        }
        else {
            events.append(self.cake.director.eventService.getFakeAllEvents())
        }
        
        self.tableView.reloadData()
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let event:IEvent = self.events[indexPath.section][indexPath.row]
        let cell:IEventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! IEventCell
        
        cell.configure(event: event)
        
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let event:IEvent = self.events[indexPath.section][indexPath.row]
    }
}

