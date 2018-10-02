

import Foundation
import UIKit

public protocol IWindowStack : AnyObject{
    
    var topVC:UIViewController? { get }

    func presentToTop(vc:UIViewController) -> UIWindow
    func presentAndDismissAllExcept(vc:UIViewController) -> UIWindow
    
    func tryDismiss(type:UIViewController.Type)
    func tryDismissTop()
    func tryDismissAll()
    func tryDismissAllExceptTop()
}
