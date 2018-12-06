

import Foundation

public protocol IFetchOptions{
    
}

public struct FetchOptionsPredicate: IFetchOptions{
    
    public var predicate:NSPredicate
    public var sortBy: (keyPath: String, ascending: Bool)?
    
    init(predicate:NSPredicate,  sortBy: (keyPath: String, ascending: Bool)?) {
        self.predicate = predicate
        self.sortBy = sortBy
    }
}
