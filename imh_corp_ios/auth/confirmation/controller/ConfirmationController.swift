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

class ConfirmationController : UIViewController {
    
    public enum ResendCodeState{
        case ready
        case lock
        case hiden
    }
    
    enum ConfirmationControllerStateValidation{
        case valid
        case failed
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewContainerResendCode: UIView!

    @IBOutlet weak var scrollView:UIScrollView!
    
    @IBOutlet weak var textFieldConfirmation: UITextField!

    @IBOutlet weak var labelTitleConfirmation: UILabel!
    @IBOutlet weak var labelTimeResendCode: UILabel!
    
    @IBOutlet weak var buttonSendCode: TKTransitionSubmitButton!
    @IBOutlet weak var buttonResendCode: UIButton!
    
    @IBOutlet weak var bottomConstraintViewContent: NSLayoutConstraint!
    
    //MARK: State machine
    lazy public var stateMachineResendCode:StateEngine<ResendCodeState> = buildStateMachine()
    private var stateMachineValidation:StateEngine<ConfirmationControllerStateValidation> = StateEngine<ConfirmationControllerStateValidation>()
    
    //MARK: Keyboard handler
    private var keyboardHandler:KeyboardHandler?
    
    //MARK:Resend
    private var timerResend:ITimer  = BackgroundTimer()
    
    //MARK:
    public var phone:String?
    public var codeRegion:String?
    
    //MARK: Dependence
    var cake:IConfirmationCake = Depednence.tryInject()!
    var authCake:IAuthCake = Depednence.tryInject()!
    

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
        self.configureStatesValidation()
        self.checkStateValid()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.keyboardHandler = KeyboardHandler()
        self.keyboardHandle()
        self.subscribeInputFieldsToEventTextChange()
        self.textFieldConfirmation.becomeFirstResponder()
        self.stateMachineResendCode.change(stateType: StateTypeWrapper(type: ResendCodeState.lock))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
        self.keyboardHandler = nil
        self.unSubscribeInputFieldsToEventTextChange()
        self.stateMachineResendCode.change(stateType: StateTypeWrapper(type: ResendCodeState.ready))
    }
    
  
    //MARK: IBActions
    @IBAction func touchSendCodeButton(){
        self.tryAuthorization()
    }
    
    @IBAction func touchResendCodeButton(){
         self.tryVerificationPhone()
         self.stateMachineResendCode.change(stateType: StateTypeWrapper(type: ResendCodeState.lock))
    }
    
    private func tryVerificationPhone(){
        
        if let code = self.codeRegion,
            let phone = self.phone,
            let deviceId  = UIDevice.current.identifierForVendor?.uuidString {
            
            self.authCake.authDirector.sendVerifyCode(phone: phone,
                                                      countyCode: code,
                                                      deviceId: deviceId,
                                                      success: { [unowned self] (message) in
                                                        
                                                        if message != nil{
                                                            self.showAlertInfo(message: message!, handlerActionClose: {
                                                            
                                                            })
                                                        }
                                                        else{
                                                            self.showAlertInfo(message: "Код отправлен")
                                                        }
                                                        
                                                        
            }) { (error) in
                self.showAlertInfo(message: "Не удалось выполнить запрос! Проверьте интернет подлючение")
            }
        }
    }
    
    private func tryAuthorization(){
        if let verifivcationCode = self.textFieldConfirmation.text,
            let phone = self.phone,
            let countryCode = self.codeRegion,
            let deviceId  = UIDevice.current.identifierForVendor?.uuidString {
            
            let correctPhone = phone.replacingOccurrences(of: "-", with: "")
            let correctConfirmation = verifivcationCode.replacingOccurrences(of: " ", with: "")
            
            self.startAnimationSendCodeButton()
            self.stateMachineResendCode.change(stateType: StateTypeWrapper(type: ResendCodeState.hiden))
            
            self.authCake.authDirector.authorization(phone: correctPhone,
                                                     countyCode: countryCode,
                                                     smsCode: correctConfirmation,
                                                     deviceId: deviceId,
                                                     success: {[unowned self] (session) in
                                                        
                                                        self.stopAnimationSendCodeButtonWithDelay()
                                                      
                
                                                        self.cake.router.showAlertInfo(message: "Пользователь \(session.getAccount().name!) успешно зарегестрирован!",  handlerActionClose: {
                                                            self.authCake.authRouter.startAppWithAuthorized()
                                                        })
                                                        
                                                        
            }) {[unowned self] (error) in
                
                self.stopAnimationSendCodeButtonWithDelay()
                self.stateMachineResendCode.change(stateType: StateTypeWrapper(type: ResendCodeState.ready))
                self.showAlertInfo(message: error.message())
            }
        }
    }
    
    private func startAnimationSendCodeButton(){
        self.buttonSendCode.startLoadingAnimation()
    }
    
    private func stopAnimationSendCodeButtonWithDelay(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.buttonSendCode.returnToOriginalState()
        }
    }
    
    
    //MARK :States
    private func configureStatesValidation(){
        self.stateMachineValidation.addState(type: ConfirmationControllerStateValidation.valid) { (data) in
            self.buttonSendCode.isEnabled = true
            self.buttonSendCode.alpha = 1
        }
        
        self.stateMachineValidation.addState(type: ConfirmationControllerStateValidation.failed) { (data) in
            self.buttonSendCode.isEnabled = false
            self.buttonSendCode.alpha = 0.4
        }
    }
    
    private func checkStateValid(){
        if let confirmationText = self.textFieldConfirmation.text{
            let confirmation = confirmationText.replacingOccurrences(of: " ", with: "")
            if confirmation.count == 4 {
                self.stateMachineValidation.changeState(type: ConfirmationController.ConfirmationControllerStateValidation.valid)
            }
            else{
                self.stateMachineValidation.changeState(type: ConfirmationController.ConfirmationControllerStateValidation.failed)
            }
        }
    }
    
    
    func buildStateMachine() -> StateEngine<ResendCodeState> {
        
        let stateReady = State<ResendCodeState>(type: ResendCodeState.ready)
        
        stateReady.set {[unowned self] (data) in
            self.timerResend.stop()
            self.labelTimeResendCode.text = "Отправить код еще раз"
            self.buttonResendCode.isEnabled = true
            self.viewContainerResendCode.isHidden = false
        }
        
        let stateHiden = State<ResendCodeState>(type: ResendCodeState.hiden)
        
        stateHiden.set {[unowned self] (data) in
            self.timerResend.stop()
            self.viewContainerResendCode.isHidden = true
        }
        
        let stateLock = State<ResendCodeState>(type: ResendCodeState.lock)
        
        stateLock.set {[unowned self] (data) in
            self.viewContainerResendCode.isHidden = false
            self.buttonResendCode.isEnabled = false
            
            self.timerResend.startNewAndStopOld(timeInterval: 1, countRepeats: 30, block: {[unowned self] (step) in
                
                DispatchQueue.main.async {
                      self.labelTimeResendCode.text = "Отправить повторно через: \(30 - step)"
                }
                
            }, completion: { [unowned self] in
                
                DispatchQueue.main.async {
                    self.stateMachineResendCode.change(stateType: StateTypeWrapper(type: ResendCodeState.ready))
                }
            })
        }
    
        return StateEngine<ResendCodeState>(states:[stateReady, stateLock, stateHiden], currentState: stateLock )
    }
    
    
    //MARK : - subscribe/unsubscribe text field events
    private func subscribeInputFieldsToEventTextChange(){
        self.textFieldConfirmation.addTarget(self, action: #selector(textFieldConfirmationDidChange(_:)), for: .editingChanged)

    }
    
    private func unSubscribeInputFieldsToEventTextChange(){
        self.textFieldConfirmation.removeTarget(self, action: #selector(textFieldConfirmationDidChange(_:)), for: .editingChanged)
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
    
    private func tryFormatConfirmationFromMask(){
        
        if let confirmationText = self.textFieldConfirmation.text{
            let mask:JMStringMask = JMStringMask.initWithMask("0 0 0 0")
            let formatConfirmation = mask.maskString(confirmationText)
            self.textFieldConfirmation.text = formatConfirmation
        }
    }
    
    //MARK: - UITextField Handle Event
    @objc func textFieldConfirmationDidChange(_ textField: UITextField) {
        self.checkStateValid()
        self.tryFormatConfirmationFromMask()
    }
}

