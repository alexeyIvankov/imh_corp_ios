
//  Created by Alexey Ivankov on 14.10.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation


public struct Section : IContainer, IContainerItem
{
    public let id:String;
    public let sortKey:String?;
    public var header:Header?
    public var model:AnyObject?
    
    fileprivate var rows:ContainerTemplate

    public init(id:String = "",
                sortKey:String? = nil,
                sortType:SortItemType = .ascending,
                model:AnyObject? = nil,
                header:Header? = nil)
    {
        self.id = id
        self.sortKey = sortKey
        self.model = model
        self.header = header
        self.rows = ContainerTemplate(sortType:sortType)
    }
    
    //MARK: Container
    public func add(item:IContainerItem){
        self.rows.add(item: item)
    }
    
    public func remove(id:String){
        self.rows.remove(id: id)
    }
    
    public func remove(index: Int) {
        self.rows.remove(index: index)
    }
    
    public func removeAll() {
        self.rows.removeAll()
    }
    
    public func item(id: String) -> IContainerItem? {
        return self.rows.item(id:id)
    }
    
    public func item(index: Int) -> IContainerItem? {
        return self.rows.item(index:index)
    }
    
    public func index(item: IContainerItem) -> Int? {
        return self.rows.index(item: item)
    }
    
    public func index(id: String) -> Int? {
        return self.rows.index(id:id)
    }
    
    public func allItems() -> [IContainerItem] {
        return self.rows.allItems()
    }
    
    public func count() -> Int{
        return self.rows.count()
    }
}
