//
//  TableDataSource.swift
//  ContainerTableView
//
//  Created by Alexey Ivankov on 14.10.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

open class TableContainer : IContainer
{
    fileprivate var sections:ContainerTemplate = ContainerTemplate();
    fileprivate var lock:NSRecursiveLock?;
    
    public required init(threadsafe:Bool)
    {
        if threadsafe == true{
            self.lock = NSRecursiveLock();
        }
    }
    
    func threadSaveOperation(operation:()->Void)
    {
        self.lock?.lock();
            operation();
        self.lock?.unlock();
    }
    
    //MARK: Container
    open func add(item:IContainerItem)
    {
        self.threadSaveOperation {
           self.sections.add(item: item);
        }
    }
    
    open func remove(id:String)
    {
        self.threadSaveOperation {
             self.sections.remove(id: id);
        }
    }
    
    open func remove(index:Int)
    {
        self.threadSaveOperation {
            self.sections.remove(index: index);
        }
    }
    
    open func removeAll() {
        
        self.threadSaveOperation {
            self.sections.removeAll()
        }
    }
    
    open func item(id: String) -> IContainerItem?
    {
        var item:IContainerItem? = nil;
        
        self.threadSaveOperation {
            item = self.sections.item(id:id);
        }
    
        return item;
    }
    
    
    open func item(index: Int) -> IContainerItem?
    {
        var item:IContainerItem? = nil;
        
        self.threadSaveOperation {
            item = self.sections.item(index:index);
        }
        
        return item;
    }
    
    open func index(item: IContainerItem) -> Int?
    {
        var index:Int?;
        
        self.threadSaveOperation {
            index = self.sections.index(item: item);
        }
    
        return index;
    }
    
    public func index(id: String) -> Int? {
        
        var index:Int?;
        
        self.threadSaveOperation {
            index = self.sections.index(id: id);
        }
        
        return index;
    }
    
    open func allItems() -> [IContainerItem]
    {
        var items:[IContainerItem] = [];
        
        self.threadSaveOperation {
            items = self.sections.allItems();
        }
        
        return items;
    }
    
    open func count() -> Int
    {
        var count:Int = 0;
        
        self.threadSaveOperation {
            count = self.sections.count();
        }
        
        return count;
    }
}


