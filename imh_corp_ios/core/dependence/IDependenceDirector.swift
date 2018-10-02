

import Foundation
import Cocaine

public protocol IDependenceDirector {
    
    func tryInject<T>() -> T?
    func tryRegister(assembly:I_Assembly) throws
}
