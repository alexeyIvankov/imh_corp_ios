import Foundation

class Localizator : ILocalizator {
    
    private lazy var strings:NSDictionary! = {
        if let path = Bundle.main.path(forResource: "Localizable", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        fatalError("Localizable file NOT found")
    }()
    
    
    //MARK: - ILocalizator
    func localize(str: String) -> String {
        
        guard let localizedStr:String = (self.strings.value(forKey: str) as? NSDictionary)?.value(forKey: "value") as? String else {
            assertionFailure("Missing translation for: \(str)")
            return ""
        }
        return localizedStr
    }
    
}
