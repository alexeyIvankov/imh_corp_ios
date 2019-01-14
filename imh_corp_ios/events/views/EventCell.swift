//
//  EventCell.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 14/01/2019.
//  Copyright © 2019 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit

class EventCell : UITableViewCell, IEventCell {
    
    @IBOutlet weak var labelEventName:UILabel!
    @IBOutlet weak var labelEventHandler:UILabel!
    @IBOutlet weak var labelEventDate:UILabel!
    
    private var event:IEvent!
    
    func configure(event:IEvent){
        self.event = event
        self.labelEventName.text = event.name
        self.labelEventHandler.text = event.handler
        self.labelEventDate.text = event.dateText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addTopContentInset()
    }
        
    private func addTopContentInset(){
        let frameContentView = contentView.frame
        let correctFrame = frameContentView.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0))
        contentView.frame = correctFrame
    }
    
}
