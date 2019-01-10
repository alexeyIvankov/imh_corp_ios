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

class EventsController : UIViewController {
    
    //MARK: Dependence
    var cake:IEventsCake = Depednence.tryInject()!
    
    //MARK: IBOutlets
    @IBOutlet var buttonTodayEvents:UIButton!
    @IBOutlet var buttonAllEvents:UIButton!
    

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
        
        self.navigationItem.title = "События"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: Actions
    @IBAction func buttonTodayEventsPressed(){
        self.buttonTodayEvents.isSelected = true
        self.buttonAllEvents.isSelected = false
    }
    
    @IBAction func buttonAllEventsPressed(){        
        self.buttonTodayEvents.isSelected = false
        self.buttonAllEvents.isSelected = true
    }
}

