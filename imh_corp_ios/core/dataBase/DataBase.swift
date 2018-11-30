

import Foundation
import RealmSwift

public class DataBase : IDataBase {
 
    private var contextSynch: Realm!
    private var queueAsynchOperation:DispatchQueue
    private var poolAsynchContext:[Thread:Realm]
    
    public required init(){
        contextSynch = try! Realm(configuration: Realm.Configuration.defaultConfiguration)
        queueAsynchOperation = DispatchQueue(label: "dataBase.queue.synch")
        poolAsynchContext = [:]
    }
    
    private func getAsynchContext(block: @escaping(Realm)->()){
        
        self.queueAsynchOperation.async {
            
            var context = self.poolAsynchContext[Thread.current]
         
            if context != nil{
                block(context!)
            }
            else
            {
                do{
                    context = try Realm(configuration: Realm.Configuration.defaultConfiguration)
                }
                catch{
                    fatalError("create db context failed")
                }
                
                self.poolAsynchContext[Thread.current] = context
                block(context!)
            }
        }
    }
    
    //MARK: Synch
    public func synchCreate<T>() -> T {
        return self.contextSynch.createObj(type: T.self as! Object.Type) as! T
    }
    
    public func synchWrite<T>(obj:[T]) {
        self.contextSynch.saveContext {
            
            for object in obj{
                if let realObj = object as? Object{
                    contextSynch.add(realObj, update: true)
                }
            }
        }
    }
    
    public func synch(block:()->()){
        self.contextSynch.saveContext(transaction: block)
    }
    
    public func synchFetch<T>(options: FetchOptions?) -> [T] {
        let objects = self.contextSynch.read(T.self as! Object.Type, options:options )
        return Array(objects) as! [T]
    }
    
    public func synchRemove<T>(objects: [T]){
        
        self.contextSynch.saveContext {
            contextSynch.delete(objects as! [Object])
        }
    }
    
    //MARK: Asynch
    public func asynch(block:@escaping ()->(),
                       completion: @escaping (IDataBaseContext) -> ()){
        
        self.getAsynchContext { (context) in
            context.saveContext(transaction: block)
             completion(context)
        }
    }
    
    public func asynch(context:IDataBaseContext,
                block:@escaping ()->(),
                completion: @escaping (IDataBaseContext) -> ()){
        let realmContext = context as! Realm
        realmContext.saveContext(transaction: block)
        completion(context)
    }
    
    public func asynchFetch<T>(type: T.Type, options: FetchOptions?,
                               completion: @escaping ([T], IDataBaseContext) -> ()) {
        self.getAsynchContext { (context) in
            let objects = context.read(type as! Object.Type, options:options )
            completion(Array(objects) as! [T], context)
        }
    }
    
    public func asynchFetch<T>(context: IDataBaseContext,
                               type: T.Type,
                               options: FetchOptions?,
                               completion: @escaping ([T], IDataBaseContext) -> ()) {
        let realmContext = context as! Realm
        let objects = realmContext.read(type as! Object.Type, options:options )
        completion(Array(objects) as! [T], context)
    }
}

extension Realm : IDataBaseContext{
    
    public func saveContext(transaction:()->()){
        do{
            
            if self.isInWriteTransaction == false{
                self.beginWrite()
            }
            
            transaction()
            
            try self.commitWrite()
            self.refresh()
        }
        catch {
            print("error!!!!!!!! \(error)")
        }
    }
    
    public func createObj<T: Object>(type:T.Type) -> T{
        return self.create(type as Object.Type) as! T
    }
    
    public func read<T: Object>(_ type: T.Type,
                                 options: FetchOptions?) -> Results<T> {
        
        var objects = self.objects(type)
        
        guard options != nil else {
            return objects
        }
        
        if options!.predicate != nil {
            objects = objects.filter(options!.predicate!)
        }
        
        if options!.sortBy != nil {
            objects = objects.sorted(byKeyPath: options!.sortBy!.keyPath, ascending: options!.sortBy!.ascending)
        }
        
        return objects
    }
    
}
