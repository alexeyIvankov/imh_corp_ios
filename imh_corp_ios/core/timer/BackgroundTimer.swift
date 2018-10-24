//
//  BackgroundTimer.swift
//  imh_corp_ios
//
//  Created by Alexey Ivankov on 22/10/2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation

class BackgroundTimer : ITimer {
  
    private var timer: DispatchSourceTimer?
    private var queue:DispatchQueue
    private var countPastRepeats:Int
    private var lock:NSRecursiveLock
    
    init() {
        self.queue = DispatchQueue(label: "queue.BackgroundTimer", attributes: .concurrent)
        countPastRepeats = 0
        self.lock = NSRecursiveLock()
    }
    
    func startNewAndStopOld(timeInterval: TimeInterval,
                            countRepeats:Int,
                            block: @escaping(Int)->(),
                            completion: @escaping()->()){
        
        self.stop()
        
        guard countRepeats > self.countPastRepeats else {
            return block(0)
        }
        
        self.timer = DispatchSource.makeTimerSource(queue: self.queue)
        self.timer?.schedule(deadline: .now(), repeating: DispatchTimeInterval.milliseconds(Int(timeInterval * 1000)), leeway: DispatchTimeInterval.never)
        
        timer?.setEventHandler {
           
            block(self.countPastRepeats + 1)
            
            self.executeOperationThreadSave {
                 self.countPastRepeats += 1
            }
            
            if self.countPastRepeats >= countRepeats{
                print("completion")
                self.stop()
                completion()
            }
        }
        timer?.resume()
        
    }
    
    func stop(){
        self.timer?.cancel()
        self.timer = nil
        self.executeOperationThreadSave {
            self.countPastRepeats = 0
        }
    }
    
    private func executeOperationThreadSave(operation:@escaping()->()){
        
        self.lock.lock()
        operation()
        self.lock.unlock()
    }
}
