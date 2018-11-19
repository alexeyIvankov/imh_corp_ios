
//  Created by Alexey Ivankov on 14.10.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

public struct Row : IContainerItem
{
 
    public let id:String;
    public let sortKey:String?;
    public var model:AnyObject?;
    public var cell:Cell
    
    public init(id:String = "",
                sortKey:String? = nil,
                model:AnyObject? = nil,
                cell:Cell)
    {
        self.id = id;
        self.sortKey = sortKey;
        self.model = model;
        self.cell = cell
    }
}
