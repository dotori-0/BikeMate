//
//  SignUpViewController.swift
//  Bikemate
//
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

class SignUpViewController : UIViewController {
    
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var passwordButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    private let bag = DisposeBag()
    
    private let emailSubject = BehaviorSubject<String>(value: "")
    private let passwordSubject = BehaviorSubject<String>(value: "")
    private let emailValidSubject = BehaviorSubject<Bool>(value: false)
    private let passwordValidSubject = BehaviorSubject<Bool>(value: false)
    
    
    private let loginValidSubject = BehaviorSubject<Bool>(value: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonsArray = [emailButton, passwordButton]
        
        for button in buttonsArray {
            button!.layer.masksToBounds = false
            button!.layer.shadowOffset = CGSize(width: 0, height: 0)
            button!.layer.shadowOpacity = 0.28
            button!.layer.shadowRadius = 8
        }
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.rx.text.orEmpty
            .bind(to: emailSubject)
            .disposed(by: bag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: passwordSubject)
            .disposed(by: bag)

        emailSubject.map { str -> Bool in
            if str.contains("@") && str.contains(".com") {
                return true
            }
            return false
        }
        .bind(to: emailValidSubject)
        .disposed(by: bag)
        
        passwordSubject.map { return $0.count > 4 }
        .bind(to: passwordValidSubject)
        .disposed(by: bag)
        
        Observable.zip(emailValidSubject, passwordValidSubject)
            .map { return $0 && $1 }
            .bind(to: loginValidSubject)
            .disposed(by: bag)
    }
    
    
    func validateEmail(testStr: String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidEmail = emailTest.evaluate(with: testStr)
        
        if isValidEmail == true { }
        else { presentAlert(message: "잘못된 이메일 형식입니다.") }
    }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        presentAlertAndPop(message: "회원가입에 성공하였습니다. \n 로그인해 주세요.", completion: {        self.navigationController?.popViewController(animated: true)})
    }
}

extension SignUpViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == emailTextField {
        validateEmail(testStr: textField.text!)
        passwordTextField.becomeFirstResponder()
    } else {
        passwordTextField.resignFirstResponder()
    }
    return true
  }
}
