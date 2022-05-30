//
//  SignInViewController.swift
//  Bikemate
//
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

class SignInViewController : UIViewController {
    
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var passwordButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var topVC: UIViewController!
    
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
        
        loginButton.rx.tap
            .subscribe(onNext: {
                let dBag = DisposeBag()
                
                Observable.zip(self.emailSubject, self.passwordSubject)
                    .subscribe(onNext: { email, pw in
                        DatabaseManager.shared.login(email: email, password: pw) {
                            self.dismiss(animated: true) {
                                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "maintabbarVC") as! MainTabBarController
                                
                                let _ = MobilityChartDataViewController()
                                
                                
                                let mobilityVC = UIStoryboard(name: "Chart", bundle: nil).instantiateViewController(withIdentifier:
 "chartVC") as! MobilityChartDataViewController
                                
                                mobilityVC.viewDidLoad()
                                mobilityVC.viewWillAppear(false)
                                mobilityVC.loadData()

                                
                                vc.modalPresentationStyle = .fullScreen
                                self.topVC.present(vc, animated: true, completion: nil)
                                
                            }
                        } loginFailed: {
                            self.presentAlert(message: "이메일 또는 비밀번호를 확인해주세요.")
                        }
                    })
                    .disposed(by: dBag)
            })
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
        DatabaseManager.shared.login(email: emailTextField.text!, password: passwordTextField.text!, loginSucceeded: {self.navigationController?.popViewController(animated: true)}, loginFailed: {})
    }
    
    
    @IBAction func signUpButtonClicked(_ sender: Any) {        
        guard let signUpViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewController(withIdentifier: "signupVC") as? SignUpViewController else { fatalError() }
        
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
}


extension SignInViewController: UITextFieldDelegate {
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

extension UIViewController {
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentAlertAndPop(message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
