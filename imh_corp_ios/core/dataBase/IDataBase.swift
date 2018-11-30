
import Foundation

public protocol IDataBaseContext : class{
    
}

public protocol IDataBase : class {
    
    //MARK: Synch
    func synchWrite<T>(obj:[T])
    func synchCreate<T>() -> T
    func synch(block:()->())
    func synchFetch<T>(options: FetchOptions?) -> [T]
    func synchRemove<T>(objects: [T])
    
    //MARK: Asynch
    func asynch(block:@escaping ()->(),
                completion: @escaping (IDataBaseContext) -> ())
    
    func asynch(transactions:[()->()],
                completion: @escaping (IDataBaseContext) -> ())
    
    func asynch(context:IDataBaseContext,
                block:@escaping ()->(),
                completion: @escaping (IDataBaseContext) -> ())
    
    func asynch(context:IDataBaseContext,
                transactions:[()->()],
                completion: @escaping (IDataBaseContext) -> ())
    
    func asynchFetch<T>(type: T.Type, options: FetchOptions?,
                        completion: @escaping ([T], IDataBaseContext) -> ())
    
    func asynchFetch<T>(context:IDataBaseContext,
                        type: T.Type,
                        options: FetchOptions?,
                        completion: @escaping ([T], IDataBaseContext) -> ())
}

