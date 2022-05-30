//
//  ViewController.swift
//  Bikemate
//
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewcontroller")
        let _ = BoardManager.shared
        let _ = DatabaseManager.shared
        let _ = UserDatabaseManager.shared
        let _ = BikeDatabaseManager.shared
        let _ = GroupManager.shared
        let vc = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewController(withIdentifier: "signinVC") as! SignInViewController
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        vc.topVC = self
        self.present(nav, animated: true, completion: nil)
        
    }

    
    func succeeded() {
        
    }

    func failed() {
        
    }
}

