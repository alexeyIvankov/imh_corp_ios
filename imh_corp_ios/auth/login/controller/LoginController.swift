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
import JMMaskTextField

class LoginController : UIViewController, WKNavigationDelegate{
    
    enum LoginControllerStateValidation{
        case valid
        case failed
    }
    
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
    
     //MARK:
    private var keyboardHandler:KeyboardHandler?
    private var stateEngine:StateEngine<LoginControllerStateValidation> = StateEngine<LoginControllerStateValidation>()
    
    

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
        self.configureStates()
        self.checkStateValid()
        
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
  
    
    private func tryVerificationPhone(){
        
        if let code = self.textFieldCountryCode.text,
            let phone = self.textFieldLogin.text,
            let deviceId  = UIDevice.current.identifierForVendor?.uuidString {
            
            let correctPhone = phone.replacingOccurrences(of: "-", with: "")
            
            self.startAnimationLoginButton()
            
            self.authCake.authDirector.sendVerifyCode(phone: correctPhone,
                                                      countyCode: code,
                                                      deviceId: deviceId,
                                                      success: { [unowned self] (message) in
                                                        
                                                        self.stopAnimationLoginButtonWithDelay()
                                                       
                                                        
                                                        if message != nil{
                                                            self.showAlertInfo(message: message!, handlerActionClose: { [unowned self]  in
                                                                
                                                                self.cake.router.handleTouchNextButton(phone: phone, codeRegion: code)
                                                            })
                                                        }
                                                        else{
                                                            self.cake.router.handleTouchNextButton(phone: phone, codeRegion: code)
                                                        }
                                                        
                                                        
            }) { [unowned self](error) in
                
                self.stopAnimationLoginButtonWithDelay()
                self.showAlertInfo(message: error.message())
            }
        }
    }

    private func startAnimationLoginButton(){
        self.buttonLogin.startLoadingAnimation()
    }
    
    private func stopAnimationLoginButtonWithDelay(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
             self.buttonLogin.returnToOriginalState()
        }
    }
    
    //MARK :States
    private func configureStates(){
        self.stateEngine.addState(type: LoginController.LoginControllerStateValidation.valid) { (data) in
            self.buttonLogin.isEnabled = true
            self.buttonLogin.alpha = 1
            
        }
        
        self.stateEngine.addState(type: LoginController.LoginControllerStateValidation.failed) { (data) in
            self.buttonLogin.isEnabled = false
            self.buttonLogin.alpha = 0.4
        }
    }
    
    private func checkStateValid(){
        if let text =  self.textFieldLogin.text{
            
            if countryCodeIsRussia() == true {
                
                let login = text.replacingOccurrences(of: "-", with: "")
                
                if login.count == 10{
                    self.stateEngine.changeState(type: LoginController.LoginControllerStateValidation.valid)
                }
                else {
                    self.stateEngine.changeState(type: LoginController.LoginControllerStateValidation.failed)
                }
            }
            else {
                
                if text.count > 3{
                    self.stateEngine.changeState(type: LoginController.LoginControllerStateValidation.valid)
                }
                else {
                    self.stateEngine.changeState(type: LoginController.LoginControllerStateValidation.failed)
                }
                
            }
        }
        else {
             self.stateEngine.changeState(type: LoginController.LoginControllerStateValidation.failed)
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
    
    private func countryCodeIsRussia() -> Bool{
     
        if let countyCode = self.textFieldCountryCode.text{
            
            if countyCode == "+7" || countyCode == "8"{
                return true
            }
            else {
                return false
            }
        }
        else{
            return false
        }
    }
    
    private func tryFormatLoginFromMask(){
        
        if self.countryCodeIsRussia() == true {
            
            if let login = self.textFieldLogin.text{
                let mask:JMStringMask = JMStringMask.initWithMask("000-000-00-00")
                let formatLogin = mask.maskString(login)
                self.textFieldLogin.text = formatLogin
            }
        }
    }
    
    //MARK: - UITextField Handle Event
    @objc func textFieldLoginDidChange(_ textField: UITextField) {
        self.checkStateValid()
        self.tryFormatLoginFromMask()
    }
    
    @objc func textFieldPasswordDidChange(_ textField: UITextField) {
        
    }
}

