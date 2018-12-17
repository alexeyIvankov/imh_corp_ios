

import Foundation
import UIKit

extension UIStoryboard {
    
    func load<T>() -> T?{

        let identifier:String = String(describing: T.self)
        return self.instantiateViewController(withIdentifier: identifier) as? T
    }
    
    func load<T>(id:String) -> T?{
        return self.instantiateViewController(withIdentifier: id) as? T
    }
}
