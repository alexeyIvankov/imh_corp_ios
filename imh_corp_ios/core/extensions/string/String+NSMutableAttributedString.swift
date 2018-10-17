
import Foundation

extension String {
    
    func toAttributedString(attributes:[NSAttributedString.Key : Any]?) -> NSAttributedString{
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    func toMutableAttributedString() -> NSMutableAttributedString{
        return NSMutableAttributedString(string: self)
    }
    
    func range(of:String) -> NSRange {
        return NSMutableString(string: self).range(of: of, options: NSString.CompareOptions.caseInsensitive)
    }
}
