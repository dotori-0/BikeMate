//
//  BeforeGroupingViewController.swift
//  Bikemate
//
//  Created by s e on 2022/02/18.
//

import UIKit

class BeforeGroupingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("@@@ view Did load")
        
        self.navigationController?.navigationBar.isHidden = true

    }
    
    @IBAction func recommendButtonClicked(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "priorityselectVC") as? PrioritySelectViewController else { fatalError() }
        
        
        
        //push
        
        //데이터 전송 (전환을 하기전에)
        
//        viewController.data = "Test"
               
        //BoardManager.shared.postNewBoard(num: <#T##String#>, uid: <#T##String#>, userName: <#T##String#>, title: <#T##String#>, content: <#T##String#>, createdAt: <#T##String#>, modifiedAt: <#T##String#>)
      
        self.navigationController?.pushViewController(viewController, animated: true)
        //init
        //viewdidload ....
        
        //modal  -> Present
        
//        viewController.modalPresentationStyle = .fullScreen
//        self.present(viewController, animated: true, completion: nil)
    }
    

//    @IBAction func healthkitTestButton(_ sender: Any) {
//        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "healthkittestVC") as? HealthKitTestViewController else { fatalError() }
//
//        self.navigationController?.pushViewController(viewController, animated: true)
//    }
    
}
