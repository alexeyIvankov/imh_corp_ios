

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
    
    private func getNeededAsynchContextFromPool(block: @escaping(Realm)->()){
        
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
    
    public func synchFetch<T>(options: IFetchOptions?) -> [T] {
        let objects = self.contextSynch.read(T.self as! Object.Type, options:options )
        return Array(objects) as! [T]
    }
    
    public func synchRemove<T>(objects: [T]){
        
        self.contextSynch.saveContext {
            contextSynch.delete(objects as! [Object])
        }
    }
    
    //MARK: Asynch

    
    public func asynchWrite<T>(transaction:@escaping ()->([T]),
                        completion: @escaping (IDataBaseContext) -> ()){
        
        self.getNeededAsynchContextFromPool { (context) in
            
            context.saveContext{
                context.add(transaction() as! [Object])
            }
            completion(context)
        }
    }
    
    public func asynchWrite<T>(context:IDataBaseContext,
                        transaction:@escaping ()->([T]),
                        completion: @escaping (IDataBaseContext) -> ()){
        
        if let realm = context as? Realm{
            realm.saveContext {
                realm.add(transaction() as! [Object])
            }
            completion(context)
        }
    }
    
    
    public func asynchWrite<T>(transactions:[()->([T])],
                        completion: @escaping (IDataBaseContext) -> ()){
       
        self.getNeededAsynchContextFromPool { (context) in
            
            for transaction in transactions{
                context.saveContext{
                    context.add(transaction() as! [Object])
                }
            }
            completion(context)
        }
    }
    
    public func asynchUpdate(context:IDataBaseContext,
                      block: @escaping ()->(),
                      completion: @escaping (IDataBaseContext) -> ()){
        
        (context as? Realm)?.saveContext {
            block()
            completion(context)
        }
    }
    
    public func asynchFetch<T>(type: T.Type, options: IFetchOptions?,
                               completion: @escaping ([T], IDataBaseContext) -> ()) {
        self.getNeededAsynchContextFromPool { (context) in
            let objects = context.read(type as! Object.Type, options:options )
            completion(Array(objects) as! [T], context)
        }
    }
    
    public func asynchFetch<T>(context: IDataBaseContext,
                               type: T.Type,
                               options: IFetchOptions?,
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
            fatalError("save object failed")
        }
    }
    
    
    public func createObj<T>(type:T.Type) -> T{
        return self.create(type as! Object.Type) as! T
    }
    
    public func createObj<T>(type:T.Type, value:Any, update:Bool) -> T{
        return self.create(type as! Object.Type, value: value, update: update) as! T
    }
    
    public  func getObj<T>(type:T.Type, primaryKey:String) -> T{
        return self.object(ofType: type as! Object.Type, forPrimaryKey: primaryKey) as! T
    }
    
    public func read<T: Object>(_ type: T.Type,
                                 options: IFetchOptions?) -> Results<T> {
        
        var objects = self.objects(type)
        
        guard options != nil else {
            return objects
        }
        
        if let fetchPredicate:FetchOptionsPredicate = options as? FetchOptionsPredicate{
           
            objects = objects.filter(fetchPredicate.predicate)
            
            if fetchPredicate.sortBy != nil {
                objects = objects.sorted(byKeyPath: fetchPredicate.sortBy!.keyPath, ascending: fetchPredicate.sortBy!.ascending)
            }
        }
        
        
        return objects
    }
    
}
