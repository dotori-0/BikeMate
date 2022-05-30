//
//  GroupPersonProfileViewController.swift
//  Bikemate
//
//  Created by s e on 2022/02/18.
//

import UIKit

class GroupPersonProfileViewController: UIViewController {

    
    var otherUserModel: OtherUserModel!
    var otherUser: OtherUserModel!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userGroupName: UILabel!
    
    @IBOutlet weak var profileView: UIView!
    
    @IBOutlet weak var userGender: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userPreferredSpace: UILabel!
    @IBOutlet weak var userPreferredTime: UILabel!
    @IBOutlet weak var userHowOften: UILabel!
    @IBOutlet weak var userAverageTime: UILabel!
    @IBOutlet weak var userAverageDistance: UILabel!
    @IBOutlet weak var userAverageSpeed: UILabel!
    
    var gender: String = ""
    var location: String = ""
    var preferredSpace: String = ""
    var preferredTime: String = ""
    var howOften: String = ""
    var averageTime: String = ""
    var averageDistance: String = ""
    var averageSpeed: String = ""
    
    var userId: String = ""
    
    // var otherUser:

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        profileView.layer.masksToBounds = false
        profileView.layer.shadowOffset = CGSize(width: 0, height: 0)
        profileView.layer.shadowOpacity = 0.28
        profileView.layer.shadowRadius = 8
        profileView.layer.cornerRadius = 15
        
        userName.text = otherUserModel.name
        userGroupName.text = otherUserModel.groupId
        userAge.text = "\(otherUserModel.age)"
        
        
        userGender.text =  otherUserModel.gender.rawValue
        userLocation.text = otherUserModel.location.rawValue
        userPreferredSpace.text = otherUserModel.prefer_space.rawValue
        userPreferredTime.text = otherUserModel.prefer_time.rawValue
        userHowOften.text = otherUserModel.how_often.rawValue
        userAverageTime.text = "\(otherUserModel.averageTime) 시간"
        userAverageDistance.text = "\(otherUserModel.averageDistance) km"
        userAverageSpeed.text = "\(otherUserModel.averageSpeed) km/h"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
