

import Foundation


public struct FetchOptions{
    
    public var predicate:NSPredicate?
    public var sortBy: (keyPath: String, ascending: Bool)?
}
