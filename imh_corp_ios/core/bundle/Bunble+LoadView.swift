

import Foundation
import UIKit

extension Bundle {
    
    static func loadView(name: String) -> UIView {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? UIView {
            return view
        }
        
        fatalError("Could not load view")
    }
}
