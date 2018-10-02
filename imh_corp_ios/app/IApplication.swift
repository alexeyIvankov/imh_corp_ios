
import Foundation

public protocol IApplication{
    
    var appDelegate:IAppDelegate? { get }
    var dependenceDirector:IDependenceDirector { get }
    var localizator:ILocalizator { get }
}
