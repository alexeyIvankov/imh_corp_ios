

import Foundation
import UIKit

class WindowStack : IWindowStack {
    
    var topVC:UIViewController? { get { return current?.window.rootViewController}}
    private var current:Node?
    
    init(win:UIWindow){
        current = Node(win: win)
    }
    
    
    //MARK: IAboveAllPresenter
    @discardableResult
    func presentToTop(vc: UIViewController) -> UIWindow
    {
        buildCurrentIfNeeded()
        
        if isEmptyCurrent() {
            configureCurrent(vc: vc)
        }
        else{
            pushToTop(node: buildNode(vc: vc))
        }
    
        current!.window.makeKeyAndVisible()
        
        return current!.window
    }
    
    @discardableResult
    func presentAndDismissAllExcept(vc:UIViewController) -> UIWindow{
       
        self.tryDismissAllExceptTop()
        let w = self.presentToTop(vc: vc)
        
        return w
    }
    
 
    func tryDismiss(type:UIViewController.Type){
        
        var node = current
        
        while node != nil {
            
            if node?.id == String(describing: type){
                
                node?.window.isHidden = true
                node?.window.rootViewController?.view.removeFromSuperview()
                self.pop(node: node!)
            }
            node = node?.back
        }
    }
    
    func tryDismissTop() {
        
        let popNode = popTop()
        
        if popNode != nil {
            popNode!.window.isHidden = true
            popNode?.window.rootViewController?.view.removeFromSuperview()
        }
    }
    
    func tryDismissAll() {
        
        while let node = popTop() {
            node.window.isHidden = true
            node.window.rootViewController?.view.removeFromSuperview()
        }
    }
    
    func tryDismissAllExceptTop(){
        
        var node = current?.back
        
        while node != nil {
            
            node?.window.isHidden = true
            node?.window.rootViewController?.view.removeFromSuperview()
            self.pop(node: node!)
            node = node?.back
        }
    }
    
    private func buildCurrentIfNeeded(){
        
        if current == nil {
            current = buildNode()
        }
    }
    
    private func isEmptyCurrent() -> Bool {
        return current?.window.rootViewController == nil ? true : false
    }
    
    private func configureCurrent(vc:UIViewController){
        current?.window.backgroundColor = UIColor.white
        current?.window.rootViewController = vc
        current?.id = String(describing: vc.classForCoder)
    }
    
    private func buildNode() -> Node{
        return Node(win: UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)))
    }
    
    private func buildNode(vc:UIViewController) -> Node {
        
        let node = buildNode()
        node.id = String(describing: vc.classForCoder)
        node.window.backgroundColor = UIColor.white
        node.window.rootViewController = vc
        node.window.windowLevel = current!.window.windowLevel + 1
        
        return node
    }
    
    private func pushToTop(node:Node){
        
        if current == nil{
            current = node
        }
        else
        {
            node.back = current
            current!.next = node
            current = node
        }
        
    }
    
    private func popTop() -> Node?{

        guard current != nil else {
            return nil
        }

        let popNode:Node  = current!
        
        if current!.back == nil{
            current = nil
        }
        else
        {
            current = current!.back!
            current!.next = nil
        }
        
        return popNode
    }
    
    private func pop(node:Node){
        
        node.back?.next = node.next
        node.next?.back = node.back
        
        node.next = nil
        node.back = nil
    }
}

fileprivate class Node{
    var window:UIWindow
    var id:String?
    var next:Node?
    var back:Node?
    
    required init(win:UIWindow, id:String? = nil, next:Node? = nil, back:Node? = nil){
        self.window = win
        self.next = next
        self.back = back
        self.id = id
    }
}
