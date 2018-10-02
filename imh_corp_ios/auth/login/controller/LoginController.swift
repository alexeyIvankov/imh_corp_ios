//
//  LoginController.swift
//  IMH_BI
//
//  Created by Alexey Ivankov on 24.08.2018.
//  Copyright © 2018 Industrial Metallurgical Holding. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import KeyboardHandler

class LoginController : UIViewController, WKNavigationDelegate{
    
    //MARK: IBOutlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewContainerLogin: UIView!
    @IBOutlet weak var viewContainerPassword: UIView!
    @IBOutlet weak var viewContainerEnterButton: UIView!
    
    @IBOutlet weak var switcher:UISwitch!
    
    @IBOutlet weak var imageViewIcon: UIImageView!
    
    @IBOutlet weak var scrollView:UIScrollView!
    
    @IBOutlet weak var textFieldLogin: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var buttonLogin: UIButton!
    
    //MARK: Dependence
    var cake:ILoginCake = Depednence.tryInject()!
    

    private var keyboardHandler:KeyboardHandler = KeyboardHandler()
    

    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
        self.keyboardHandle()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: IBActions
    @IBAction func touchLoginButton(){
        self.tryLogin()
    }
    
    @IBAction func switcherChange(sw:UISwitch){
  
    }
    
    
    private func tryLogin(){
        
    }

    
    //MARK : - subscribe/unsubscribe text field events
    private func subscribeInputFieldsToEventTextChange(){
        self.textFieldLogin.addTarget(self, action: #selector(textFieldLoginDidChange(_:)), for: .editingChanged)
        self.textFieldPassword.addTarget(self, action: #selector(textFieldPasswordDidChange(_:)), for: .editingChanged)
    }
    
    private func unSubscribeInputFieldsToEventTextChange(){
        self.textFieldLogin.removeTarget(self, action: #selector(textFieldLoginDidChange(_:)), for: .editingChanged)
        self.textFieldPassword.removeTarget(self, action: #selector(textFieldPasswordDidChange(_:)), for: .editingChanged)
    }
    
    //MARK :- Keyboard handler
    private func keyboardHandle(){
        
        self.keyboardHandler.setAnimateWillShowHandler { (frameKeyboard) in
            
            if frameKeyboard != nil && frameKeyboard!.height > 100.00 {
                
                var newContentOffset = self.scrollView.contentOffset
                newContentOffset.y = frameKeyboard!.size.height - (self.viewContainer.frame.size.height - (self.viewContainerLogin.frame.height + self.viewContainerLogin.frame.origin.y))
                
                self.scrollView.setContentOffset(newContentOffset, animated: true)
            }
        }
        
        self.keyboardHandler.setAnimateWillHideHandler {
            
            var newContentOffset = self.scrollView.contentOffset
            newContentOffset.y = 0
            self.scrollView.setContentOffset(newContentOffset, animated: true)
        }
    }
    
    //MARK: - UITextField Handle Event
    
    @objc func textFieldLoginDidChange(_ textField: UITextField) {
        
    }
    
    @objc func textFieldPasswordDidChange(_ textField: UITextField) {
        
    }
    
}

