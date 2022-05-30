//
//  PrioritySelectViewController.swift
//  Bikemate
//
//  Created by s e on 2022/02/18.
//

import UIKit
import SwiftUI

class PrioritySelectViewController: UIViewController {

    @IBOutlet weak var groupLabel: UILabel!
    
    
    @IBOutlet weak var ageButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var averageTimeButton: UIButton!
    @IBOutlet weak var averageSpeedButton: UIButton!
    @IBOutlet weak var averageDistanceButton: UIButton!
    @IBOutlet weak var preferredSpaceButton: UIButton!
    @IBOutlet weak var preferredTimeButton: UIButton!
    @IBOutlet weak var howOftenButton: UIButton!
    
    @IBOutlet weak var selectedOne: UIButton!
    @IBOutlet weak var selectedTwo: UIButton!
    @IBOutlet weak var selectedThree: UIButton!
    
    
    var selectedOptions = [String]()
    var isRRcommend: Bool = false
    var numR: Int = 0
    var recommendedGroupName: String = ""
    
    @IBOutlet weak var selectView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GroupManager.shared.recommendedGroupArray = []
        
        let buttonArray = [ageButton, genderButton, locationButton, averageTimeButton, averageSpeedButton, averageDistanceButton, preferredSpaceButton, preferredTimeButton, howOftenButton]
        
        for button in buttonArray {
            button!.layer.cornerRadius = 8
        }
        
        selectView.layer.masksToBounds = false
        selectView.layer.shadowOffset = CGSize(width: 0, height: 0)
        selectView.layer.shadowOpacity = 0.28
        selectView.layer.shadowRadius = 8
        selectView.layer.cornerRadius = 15
        
        [selectedOne, selectedTwo, selectedThree].forEach { button in
            button!.isHidden = false
            button!.layer.cornerRadius = 8
            
        }
        // Do any additional setup after loading the view.
        // self.groupLabel.text = data
    }
    
    func optionButtonClicked(selectedButton: UIButton!, titleText: String) {
        selectedButton.setTitle(titleText, for: .normal)
        selectedButton.isHidden = false
        selectedButton.setTitleColor(.black, for: .normal)
        selectedButton.backgroundColor = UIColor(named: "highlightColor")
    }
    
    @IBAction func ageButtonClicked(_ sender: Any) {
        ageButton.backgroundColor = UIColor(named: "highlightColor")
        selectedOptions.append("age")
        
        if selectedOptions.count == 1 {
            optionButtonClicked(selectedButton: selectedOne, titleText: "나이")
        } else if selectedOptions.count == 2 {
            optionButtonClicked(selectedButton: selectedTwo, titleText: "나이")
        } else if selectedOptions.count == 3 {
            optionButtonClicked(selectedButton: selectedThree, titleText: "나이")
        }
    }
    
    @IBAction func genderButtonClicked(_ sender: Any) {
        genderButton.backgroundColor = UIColor(named: "highlightColor")
        selectedOptions.append("gender")

        if selectedOptions.count == 1 {
            optionButtonClicked(selectedButton: selectedOne, titleText: "성별")
        } else if selectedOptions.count == 2 {
            optionButtonClicked(selectedButton: selectedTwo, titleText: "성별")
        } else if selectedOptions.count == 3 {
            optionButtonClicked(selectedButton: selectedThree, titleText: "성별")
        }
//        groupModel.gender = UserModel.shared.gender
    }
    
    
    @IBAction func locationButtonClicked(_ sender: Any) {
        locationButton.backgroundColor = UIColor(named: "highlightColor")
        selectedOptions.append("location")

        if selectedOptions.count == 1 {
            optionButtonClicked(selectedButton: selectedOne, titleText: "지역")
        } else if selectedOptions.count == 2 {
            optionButtonClicked(selectedButton: selectedTwo, titleText: "지역")
        } else if selectedOptions.count == 3 {
            optionButtonClicked(selectedButton: selectedThree, titleText: "지역")
        }
    }
    
    @IBAction func averageTimeButtonClicked(_ sender: Any) {
        averageTimeButton.backgroundColor = UIColor(named: "highlightColor")
        selectedOptions.append("average time")
        
        if selectedOptions.count == 1 {
            optionButtonClicked(selectedButton: selectedOne, titleText: "주행 시간")
        } else if selectedOptions.count == 2 {
            optionButtonClicked(selectedButton: selectedTwo, titleText: "주행 시간")
        } else if selectedOptions.count == 3 {
            optionButtonClicked(selectedButton: selectedThree, titleText: "주행 시간")
        }
    }
    
    @IBAction func averageSpeedButtonClicked(_ sender: Any) {
        averageSpeedButton.backgroundColor = UIColor(named: "highlightColor")
        selectedOptions.append("average speed")
        
        if selectedOptions.count == 1 {
            optionButtonClicked(selectedButton: selectedOne, titleText: "주행 속도")
        } else if selectedOptions.count == 2 {
            optionButtonClicked(selectedButton: selectedTwo, titleText: "주행 속도")
        } else if selectedOptions.count == 3 {
            optionButtonClicked(selectedButton: selectedThree, titleText: "주행 속도")
        }
    }
    
    @IBAction func averageDistanceButtonClicked(_ sender: Any) {
        averageDistanceButton.backgroundColor = UIColor(named: "highlightColor")
        selectedOptions.append("average distance")
        
        if selectedOptions.count == 1 {
            optionButtonClicked(selectedButton: selectedOne, titleText: "주행 거리")
        } else if selectedOptions.count == 2 {
            optionButtonClicked(selectedButton: selectedTwo, titleText: "주행 거리")
        } else if selectedOptions.count == 3 {
            optionButtonClicked(selectedButton: selectedThree, titleText: "주행 거리")
        }
    }
    
    
    @IBAction func preferredSpaceButtonClicked(_ sender: Any) {
        preferredSpaceButton.backgroundColor = UIColor(named: "highlightColor")
        selectedOptions.append("preferred space")
        
        if selectedOptions.count == 1 {
            optionButtonClicked(selectedButton: selectedOne, titleText: "선호 장소")
        } else if selectedOptions.count == 2 {
            optionButtonClicked(selectedButton: selectedTwo, titleText: "선호 장소")
        } else if selectedOptions.count == 3 {
            optionButtonClicked(selectedButton: selectedThree, titleText: "선호 장소")
        }
    }
    
    @IBAction func preferredTimeButtonClicked(_ sender: Any) {
        preferredTimeButton.backgroundColor = UIColor(named: "highlightColor")
        selectedOptions.append("preferred time")
        
        if selectedOptions.count == 1 {
            optionButtonClicked(selectedButton: selectedOne, titleText: "선호 시간대")
        } else if selectedOptions.count == 2 {
            optionButtonClicked(selectedButton: selectedTwo, titleText: "선호 시간대")
        } else if selectedOptions.count == 3 {
            optionButtonClicked(selectedButton: selectedThree, titleText: "선호 시간대")
        }
    }
    
    @IBAction func howOftenButtonClicked(_ sender: Any) {
        howOftenButton.backgroundColor = UIColor(named: "highlightColor")
        selectedOptions.append("how often")
        
        if selectedOptions.count == 1 {
            optionButtonClicked(selectedButton: selectedOne, titleText: "주 운동 횟수")
        } else if selectedOptions.count == 2 {
            optionButtonClicked(selectedButton: selectedTwo, titleText: "주 운동 횟수")
        } else if selectedOptions.count == 3 {
            optionButtonClicked(selectedButton: selectedThree, titleText: "주 운동 횟수")
        }
    }
    
   

    @IBAction func checkButtonClicked(_ sender: Any) {
        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "groupingresultVC") as? GroupingResultViewController else { fatalError() }
        
        let option = self.selectedOptions[2]
        for groupModel in makeFinalGroups(with: option) {
            groupModel.storeGroupInDatabase()
        }
        viewController.isRRcommend = self.isRRcommend
        viewController.numR = self.numR
        self.isRRcommend = false
        viewController.recommendedGroupName = self.recommendedGroupName
        


        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        //push -> pop
        
        guard let viewController = UIStoryboard(name: "Group", bundle: nil).instantiateViewController(withIdentifier: "groupcommunitymainVC") as? GroupCommunityMainViewController else { fatalError() }
        
    
        self.navigationController?.pushViewController(viewController, animated: true)
        
        
        //modal -> dismiss 끄기
//        self.dismiss(animated: true, completion: nil)

    }
    
    private func setSharedGroupModel() -> GroupModel {
        let groupModel = GroupModel()
        self.selectedOptions.forEach { option in
            
            
            if option == self.selectedOptions[2] {
                return
            }
            
            if option == "age" {
                if UserModel.shared.age < 30 {
                    groupModel.age = .twenty
                } else if UserModel.shared.age < 40 {
                    groupModel.age = .thirty
                } else if UserModel.shared.age < 50 {
                    groupModel.age = .fourty
                } else if UserModel.shared.age < 60 {
                    groupModel.age = .fifty
                } else if UserModel.shared.age < 70 {
                    groupModel.age = .sixty
                }
                //......
            } else if option == "gender" {
                groupModel.gender = UserModel.shared.gender
            } else if option == "location" {
                groupModel.location = UserModel.shared.location
            } else if option == "average time" {
                // 헬스킷 연동 후 수정
                if UserModel.shared.averageTime < 24 {
                    groupModel.averageTime = .one
                } else if UserModel.shared.averageTime < 40 {
                    groupModel.averageTime = .two
                } else if UserModel.shared.averageTime < 101 {
                    groupModel.averageTime = .three
                } else if UserModel.shared.averageTime > 101{
                    groupModel.averageTime = .four
                }
                
            } else if option == "average speed" {
                // 헬스킷 연동 후 수정
                if UserModel.shared.averageSpeed < 18 {
                    groupModel.averageSpeed = .one
                } else if UserModel.shared.averageSpeed < 21 {
                    groupModel.averageSpeed = .two
                } else if UserModel.shared.averageSpeed < 23 {
                    groupModel.averageSpeed = .three
                } else if UserModel.shared.averageSpeed >= 23{
                    groupModel.averageSpeed = .four
                }
                
                
            } else if option == "average distance"{
                // 헬스킷 연동 후 수정
                if UserModel.shared.averageDistance < 7000 {
                    groupModel.averageDistance = .one
                } else if UserModel.shared.averageDistance < 14000 {
                    groupModel.averageDistance = .two
                } else if UserModel.shared.averageDistance < 35000 {
                    groupModel.averageDistance = .three
                } else if UserModel.shared.averageDistance > 35000 {
                    groupModel.averageDistance = .four
                }
                
            } else if option == "preferred space"{
                groupModel.prefer_space = UserModel.shared.prefer_space
            } else if option == "preferred time" {
                groupModel.prefer_time = UserModel.shared.prefer_time
            } else if option == "how often" {
                groupModel.how_often = UserModel.shared.how_often
            }
        }
        
        return groupModel
    }
    
    private func makeFinalGroups(with option: String) -> [GroupModel] {
        
        var groupModelArray = [GroupModel]()
        
        if option == "age" {
            for ageT in ageT.allCases {
                let groupModel = self.setSharedGroupModel()
                groupModel.age = ageT
                groupModelArray.append(groupModel)
            }
            //......
        } else if option == "gender" {
            for gender in Gender.allCases {
                let groupModel = self.setSharedGroupModel()
                groupModel.gender = gender
                groupModelArray.append(groupModel)
            }
        } else if option == "location" {
            for loc in Location.allCases {
                let groupModel = self.setSharedGroupModel()
                groupModel.location = loc
                groupModelArray.append(groupModel)
            }
        } else if option == "average time" {
            // 헬스킷 연동 후 수정
            for avT in AverageTime.allCases {
                let groupModel = self.setSharedGroupModel()
                groupModel.averageTime = avT
                groupModelArray.append(groupModel)
            }
        } else if option == "average speed" {
            // 헬스킷 연동 후 수정
            for avS in AverageSpeed.allCases {
                let groupModel = self.setSharedGroupModel()
                groupModel.averageSpeed = avS
                groupModelArray.append(groupModel)
            }
        } else if option == "average distance"{
            // 헬스킷 연동 후 수정
            for avD in AverageDistance.allCases {
                let groupModel = self.setSharedGroupModel()
                groupModel.averageDistance = avD
                groupModelArray.append(groupModel)
            }
        } else if option == "preferred space"{
            for preferSpace in Prefer_space.allCases {
                let groupModel = self.setSharedGroupModel()
                groupModel.prefer_space = preferSpace
                groupModelArray.append(groupModel)
            }
        } else if option == "preferred time" {
            for preferTime in Prefer_time.allCases {
                let groupModel = self.setSharedGroupModel()
                groupModel.prefer_time = preferTime
                groupModelArray.append(groupModel)
            }
        } else if option == "how often" {
            for howOften in How_often.allCases {
                let groupModel = self.setSharedGroupModel()
                groupModel.how_often = howOften
                groupModelArray.append(groupModel)
            }
        }
        return groupModelArray
    }
    
    
    private func setButtonLayerRound() {
        [ageButton, genderButton, locationButton, averageTimeButton, averageSpeedButton, averageDistanceButton, preferredTimeButton, preferredSpaceButton, howOftenButton]
            .forEach {
                $0!.layer.cornerRadius = 6
            }
        
    }
}
