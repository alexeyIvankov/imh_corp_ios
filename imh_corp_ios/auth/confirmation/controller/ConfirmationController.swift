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

class ConfirmationController : UIViewController {
    
    public enum ResendCodeState{
        case ready
        case lock
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewContent: UIView!

    @IBOutlet weak var scrollView:UIScrollView!
    
    @IBOutlet weak var textFieldConfirmation: UITextField!

    @IBOutlet weak var labelTitleConfirmation: UILabel!
    @IBOutlet weak var labelTimeResendCode: UILabel!
    
    @IBOutlet weak var buttonSendCode: UIButton!
    @IBOutlet weak var buttonResendCode: UIButton!
    
    @IBOutlet weak var bottomConstraintViewContent: NSLayoutConstraint!
    
    //MARK: State machine
    lazy public var stateMachineResendCode:StateEngineTemplate<ResendCodeState> = buildStateMachine()
    
    //MARK: Keyboard handler
    private var keyboardHandler:KeyboardHandler?
    
    //MARK:Resend
    private var timerResend:ITimer  = BackgroundTimer()
    
    //MARK: Dependence
    var cake:IConfirmationCake = Depednence.tryInject()!
    var authCake:IAuthCake = Depednence.tryInject()!
    

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cake.router.setOwnwer(ownwer: self)
        self.cake.design.apply(vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.keyboardHandler = KeyboardHandler()
        self.keyboardHandle()
        self.subscribeInputFieldsToEventTextChange()
        self.textFieldConfirmation.becomeFirstResponder()
        self.stateMachineResendCode.change(stateType: StateType(type: ResendCodeState.lock))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
        self.keyboardHandler = nil
        self.unSubscribeInputFieldsToEventTextChange()
        self.stateMachineResendCode.change(stateType: StateType(type: ResendCodeState.ready))
    }
    
  
    //MARK: IBActions
    @IBAction func touchSendCodeButton(){
        self.authCake.authRouter.startAppWithAuthorized()
    }
    
    @IBAction func touchResendCodeButton(){
         self.stateMachineResendCode.change(stateType: StateType(type: ResendCodeState.lock))
    }
    
    func buildStateMachine() -> StateEngineTemplate<ResendCodeState> {
        
        let stateReady = StateTemplate<ResendCodeState>(type: ResendCodeState.ready)
        
        stateReady.set {[unowned self] (data) in
            self.timerResend.stop()
            self.labelTimeResendCode.text = "Отправить код еще раз"
            self.buttonResendCode.isEnabled = true
        }
        
        let stateLock = StateTemplate<ResendCodeState>(type: ResendCodeState.lock)
        
        stateLock.set {[unowned self] (data) in
            self.buttonResendCode.isEnabled = false
            
            self.timerResend.startNewAndStopOld(timeInterval: 1, countRepeats: 30, block: {(step) in 
                
                DispatchQueue.main.async {
                      self.labelTimeResendCode.text = "Отправить повторно через: \(30 - step)"
                }
                
            }, completion: {
                
                DispatchQueue.main.async {
                    self.stateMachineResendCode.change(stateType: StateType(type: ResendCodeState.ready))
                }
            })
        }
    
        return StateEngineTemplate<ResendCodeState>(states:[stateReady, stateLock], currentState: stateLock )
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
    
    //MARK: - UITextField Handle Event
    @objc func textFieldConfirmationDidChange(_ textField: UITextField) {
        
    }
}
