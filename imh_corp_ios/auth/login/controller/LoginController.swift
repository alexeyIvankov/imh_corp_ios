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
    @IBOutlet weak var viewContent: UIView!

    @IBOutlet weak var scrollView:UIScrollView!
    
    @IBOutlet weak var textFieldLogin: UITextField!
    @IBOutlet weak var textFieldCountryCode: UITextField!

    @IBOutlet weak var labelTitleLogin: UILabel!
    @IBOutlet weak var labelCountryName: UILabel!
    
    @IBOutlet weak var buttonLogin:TKTransitionSubmitButton!
    @IBOutlet weak var buttonSelecCountry: UIButton!
    
    @IBOutlet weak var bottomConstraintViewContent: NSLayoutConstraint!
    
    
    //MARK: Dependence
    var cake:ILoginCake = Depednence.tryInject()!
    var authCake:IAuthCake = Depednence.tryInject()!
    
    private var keyboardHandler:KeyboardHandler?
    

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
        
        self.navigationItem.title = " "
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.keyboardHandler = KeyboardHandler()
        self.keyboardHandle()
        self.subscribeInputFieldsToEventTextChange()
        self.textFieldLogin.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
        self.keyboardHandler = nil
        self.unSubscribeInputFieldsToEventTextChange()
    }
    
    //MARK: IBActions
    @IBAction func touchLoginButton(){
        self.tryVerificationPhone()
    }
    
    @IBAction func touchSelectCountryButton(){

    }
  
    
    private func tryLogin(){
        
    }
    
    private func tryVerificationPhone(){
        
        if let code = self.textFieldCountryCode.text,
            let phone = self.textFieldLogin.text,
            let deviceId  = UIDevice.current.identifierForVendor?.uuidString {
            
            self.buttonLogin.startLoadingAnimation()
            
            self.authCake.authDirector.sendVerifyCode(phone: phone,
                                                      countyCode: code,
                                                      deviceId: deviceId,
                                                      success: { (message) in
                                                        
                                                        self.buttonLogin.returnToOriginalState()
                                                        
                                                        if message != nil{
                                                            self.showAlertInfo(message: message!, handlerActionClose: {
                                                                self.cake.router.handleTouchNextButton(phone: phone, codeRegion: code)
                                                            })
                                                        }
                                                        else{
                                                            self.cake.router.handleTouchNextButton(phone: phone, codeRegion: code)
                                                        }
                                                        
                                                        
            }) { (error) in
                
                self.buttonLogin.returnToOriginalState()
                self.showAlertInfo(message: error.message())
            }
        }
    }

    
    //MARK : - subscribe/unsubscribe text field events
    private func subscribeInputFieldsToEventTextChange(){
        self.textFieldLogin.addTarget(self, action: #selector(textFieldLoginDidChange(_:)), for: .editingChanged)
        self.textFieldCountryCode.addTarget(self, action: #selector(textFieldLoginDidChange(_:)), for: .editingChanged)

    }
    
    private func unSubscribeInputFieldsToEventTextChange(){
        self.textFieldLogin.removeTarget(self, action: #selector(textFieldLoginDidChange(_:)), for: .editingChanged)
        self.textFieldCountryCode.removeTarget(self, action: #selector(textFieldLoginDidChange(_:)), for: .editingChanged)
    }
    
    //MARK :- Keyboard handler
    private func keyboardHandle(){
        
        self.keyboardHandler?.setWillShowHandler { [unowned self](frameKeyboard, duration, animationCurve) in
            
            var animateDuration:Double = 0
            var curve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue:7)
            
            if duration != nil{
                animateDuration = duration!
            }
            
            if animationCurve != nil{
                curve = animationCurve!
            }
            
            
            UIView.animate(withDuration: animateDuration,
                           delay: 0.0,
                           options: curve,
                           animations: {
                            
                            self.bottomConstraintViewContent.constant = frameKeyboard!.size.height
                            self.view.layoutIfNeeded()
            },
                           completion: nil)
        }
        
        
        self.keyboardHandler?.setWillHideHandler { [unowned self](duration, animationCurve) in
            
            var animateDuration:Double = 0
            var curve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue:7)
            
            if duration != nil{
                animateDuration = duration!
            }
            
            if animationCurve != nil{
                curve = animationCurve!
            }
            
            
            UIView.animate(withDuration: animateDuration,
                           delay: 0.0,
                           options: curve,
                           animations: {
                            
                            self.bottomConstraintViewContent.constant = 0
                            self.view.layoutIfNeeded()
            },
                           completion: nil)
        }
    }
    
    //MARK: - UITextField Handle Event
    @objc func textFieldLoginDidChange(_ textField: UITextField) {
        
    }
    
    @objc func textFieldPasswordDidChange(_ textField: UITextField) {
        
    }
}

