//
//  Container.swift
//  ContainerTableView
//
//  Created by Alexey Ivankov on 14.10.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation

public enum SortItemType {
    case descending
    case ascending
}

public protocol IContainer
{
    func add(item:IContainerItem)
    
    func item(index:Int) -> IContainerItem?
    func item(id:String) -> IContainerItem?
    
    func remove(index:Int)
    func remove(id:String)
    func removeAll()
    
    func index(item:IContainerItem) ->Int?
    func index(id:String) -> Int?
    
    func allItems() -> [IContainerItem]
 
    func count() -> Int;
}
