
import Foundation
import UIKit

extension String{
    func size(font:UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
