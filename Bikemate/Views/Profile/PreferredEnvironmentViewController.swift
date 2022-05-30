//
//  PreferredEnvironmentViewController.swift
//  Bikemate
//
//

import UIKit

class PreferredEnvironmentViewController : UIViewController {
    
    @IBOutlet weak var downtownButton: UIButton!
    @IBOutlet weak var riversideButton: UIButton!
    @IBOutlet weak var mountainButton: UIButton!
    @IBOutlet weak var parkButton: UIButton!
    
    var buttonsArray: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonsArray = [downtownButton, riversideButton, mountainButton, parkButton]
    }
    
    @IBAction func onClickButton(_ sender: UIButton) {
        deselectAllButtons()
        sender.isSelected = true
        sender.layer.cornerRadius = 20
        sender.layer.borderWidth = 4
        sender.layer.borderColor = UIColor(named: "highlightColor")?.cgColor
        
        updatePreferredEnvironmentOnUserModel(sender)
        
    }
    
    func deselectAllButtons() {
        for button in buttonsArray {
            // Set all the other buttons as normal state
            button.isSelected = false
            button.layer.borderColor = UIColor.clear.cgColor
        }
    }

    func updatePreferredEnvironmentOnUserModel(_ sender: UIButton) {
        if sender == downtownButton { UserDatabaseManager.shared.editUserPreferSpace(to: .city_road) }
        else if sender == riversideButton { UserDatabaseManager.shared.editUserPreferSpace(to: .river) }
        else if sender == mountainButton { UserDatabaseManager.shared.editUserPreferSpace(to: .mountain) }
        else if sender == parkButton { UserDatabaseManager.shared.editUserPreferSpace(to: .park) }
    }
    
    @IBAction func confirmButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
