

import Foundation

public protocol IDataBase : class {
    
    //MARK: Synch
    func synchCreate<T>() -> T
    func synchWrite<T>(obj:[T])
    func synch(block:()->())
    func synchFetch<T>(options: FetchOptions?) -> [T]
    func synchRemove<T>(objects: [T])
    
    //MARK: Asynch
    func asynchCreate<T>(type: T.Type, completion: @escaping (T) -> ())
    func asynchWrite<T>(type: T.Type, obj:[T], completion: () -> ())
    func asynchFetch<T>(options: FetchOptions?,  completion: @escaping ([T]) -> ())
    func asynchRemove<T>(objects: [T], completion: () -> ())
}


