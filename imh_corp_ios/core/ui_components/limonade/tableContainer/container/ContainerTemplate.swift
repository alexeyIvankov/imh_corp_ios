
//  Created by Alexey Ivankov on 14.10.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation

class ContainerTemplate : IContainer
{
    fileprivate var items:Array<IContainerItem> = Array<IContainerItem>();
    private let sortType:SortItemType
    
    required init(sortType:SortItemType  = .ascending){
        self.sortType = sortType
    }
    
    func sort_items()
    {
        self.items.sort { (item1, item2) -> Bool in
            
            if item1.sortKey != nil && item2.sortKey != nil{
                
                if sortType == .ascending{
                    return item1.sortKey! < item2.sortKey!
                }
                else if sortType == .descending{
                    return item1.sortKey! > item2.sortKey!
                }
                else {
                    return item1.sortKey! == item2.sortKey!
                }
            }
            else{
                return false
            }
        }
    }
    
    //MARK: Container
    func add(item:IContainerItem)
    {
        self.items.append(item);
        self.sort_items()
    }
    
    func remove(id:String)
    {
        var removeIndex:Int?;
    
        for (index,value) in self.items.enumerated()
        {
            if value.id == id
            {
                removeIndex = index;
                break;
            }
        }
        
        if removeIndex != nil && removeIndex! < self.items.count {
            self.items.remove(at: removeIndex!);
        }
        
        self.sort_items();
    }
    
    func remove(index:Int)
    {
        if index < self.items.count
        {
            self.items.remove(at: index);
            self.sort_items();
        }
    }
    
    func removeAll(){
        self.items.removeAll()
    }
    
    func item(index: Int) -> IContainerItem?
    {
        var item:IContainerItem? = nil;
        
        if  index >= 0 && index < self.items.count {
            item = self.items[index];
        }
    
        return item;
    }
    
    
    func index(item:IContainerItem) ->Int?
    {
        var index:Int? = nil;
        
        for (_index,value) in self.items.enumerated()
        {
            if value.id == item.id
            {
                index = _index;
                break;
            }
        }
        return index
    }
    
    func index(id:String) -> Int?{
        
        var index:Int? = nil;
        
        for (_index,value) in self.items.enumerated()
        {
            if value.id == id
            {
                index = _index;
                break;
            }
        }
        return index
    }
    
    func allItems() -> [IContainerItem] {
        return self.items;
    }
    
    func item(id: String) -> IContainerItem?
    {
        var item:IContainerItem? = nil;
        
        for (_,value) in self.items.enumerated()
        {
            if value.id == id
            {
                item = value;
                break;
            }
        }
        return item;
    }
    
    func count() -> Int
    {
        var count:Int = 0;
        
        count = self.items.count;
        
        return count;
    }
}
