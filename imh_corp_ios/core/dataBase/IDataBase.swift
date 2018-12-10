
import Foundation

public protocol IDataBaseContext : class{
    func createObj<T>(type:T.Type) -> T
    func createObj<T>(type:T.Type, value:Any, update:Bool) -> T
    func getObj<T>(type:T.Type, primaryKey:String) -> T
}

public protocol IDataBase : class {
    
    //MARK: Synch
    func synchWrite<T>(obj:[T])
    func synchCreate<T>() -> T
    func synch(block:()->())
    func synchFetch<T>(options: IFetchOptions?) -> [T]
    func synchRemove<T>(objects: [T])
    
    //MARK: Asynch
    
    func asynchWrite<T>(transaction:@escaping ()->([T]),
                        completion: @escaping (IDataBaseContext) -> ())
    
    func asynchWrite<T>(context:IDataBaseContext,
                        transaction:@escaping ()->([T]),
                        completion: @escaping (IDataBaseContext) -> ())
    
    
    func asynchWrite<T>(transactions:[()->([T])],
                        completion: @escaping (IDataBaseContext) -> ())
    
    func asynchUpdate(context:IDataBaseContext,
                      block: @escaping ()->(),
                      completion: @escaping (IDataBaseContext) -> ())
    
    func asynchFetch<T>(type: T.Type, options: IFetchOptions?,
                        completion: @escaping ([T], IDataBaseContext) -> ())
    
    func asynchFetch<T>(context:IDataBaseContext,
                        type: T.Type,
                        options: IFetchOptions?,
                        completion: @escaping ([T], IDataBaseContext) -> ())
}

