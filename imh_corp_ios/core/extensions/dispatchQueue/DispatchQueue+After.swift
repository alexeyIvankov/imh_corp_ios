
import Foundation

extension DispatchQueue {
    
    func runNextLoop(block:@escaping ()->Void){
        self.asyncAfter(deadline: .now() + 0.1, execute: block)
    }
    
}
