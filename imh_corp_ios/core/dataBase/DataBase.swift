

import Foundation
import RealmSwift

public class DataBase : IDataBase {

    private var contextSynch: Realm!
    private var contextAsynch: Realm!
    
    private var queueTransaction:DispatchQueue!
    
    public required init(){
        
        contextSynch = try! Realm(configuration: Realm.Configuration.defaultConfiguration)
        queueTransaction = DispatchQueue(label: "DataBase.asynchExecuteQueue")
    }
    
    private func executeAsynch(transaction: @escaping (Realm)->()){
    
        guard self.contextAsynch != nil else {
            return self.queueTransaction.async {
                 self.contextAsynch = try! Realm(configuration: Realm.Configuration.defaultConfiguration)
                 transaction(self.contextAsynch)
            }
        }
        
        self.queueTransaction.async {
            transaction(self.contextAsynch)
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
    public func asynchCreate<T>(type: T.Type, completion: @escaping (T) -> ()) {
        
        self.executeAsynch { (context) in
            completion(context.createObj(type: T.self as! Object.Type) as! T)
        }
    }
    
    public func asynchWrite<T>(type: T.Type, obj:[T], completion: () -> ()) {
        
        self.executeAsynch { (context) in
            
            context.saveContext {
                context.add(obj as! [Object])
            }
        }
    }
    
    public func asynchFetch<T>(options: FetchOptions?,  completion: @escaping ([T]) -> ()) {
        
        self.executeAsynch { (context) in
           
            let objects = context.read(T.self as! Object.Type, options:options )
            completion(Array(objects) as! [T])
        }
    }
    
    public func asynchRemove<T>(objects: [T], completion: () -> ()) {
        
        self.executeAsynch { (context) in
            
            context.saveContext {
                context.delete(objects as! [Object])
            }
        }
    }
    
}

extension Realm{
    
    public func saveContext(transaction:()->()){
        
        if self.isInWriteTransaction == false{
            self.beginWrite()
        }
        
        transaction()
        
        try! self.commitWrite()
        self.refresh()
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
