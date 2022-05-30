//
//  ProfileViewController.swift
//  Bikemate
//
//

import UIKit
import HealthKit

class ProfileViewController : UIViewController {

    
    // Banner Buttons
    @IBOutlet weak var basicProfileInfoButton: UIButton!
    @IBOutlet weak var averageSpeedButton: UIButton!
    @IBOutlet weak var maxSpeedButton: UIButton!
    @IBOutlet weak var averageDistanceButton: UIButton!
    @IBOutlet weak var totalDistanceButton: UIButton!
    @IBOutlet weak var cyclingDistanceAndDurationChartViewButton: UIButton!
    @IBOutlet weak var preferredEnvironmentButton: UIButton!
    @IBOutlet weak var ridesPerWeekButton: UIButton!
    @IBOutlet weak var preferredTimeButton: UIButton!
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var graphImageView: UIImageView!
    
    // Value Labels
    @IBOutlet weak var nameValueLabel: UILabel!
    @IBOutlet weak var genderAgeLocationValueLabel: UILabel!
    @IBOutlet weak var averageSpeedValueLabel: UILabel!
    @IBOutlet weak var maxSpeedValueLabel: UILabel!
    @IBOutlet weak var averageDistanceValueLabel: UILabel!
    @IBOutlet weak var totalDistanceValueLabel: UILabel!
    @IBOutlet weak var preferredEnvironmentValueLabel: UILabel!
    @IBOutlet weak var ridesPerWeekValueButton: UIButton!
    @IBOutlet weak var preferredTimeValueButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonsArray = [basicProfileInfoButton, averageSpeedButton, maxSpeedButton, averageDistanceButton, totalDistanceButton, cyclingDistanceAndDurationChartViewButton, preferredEnvironmentButton, ridesPerWeekButton, preferredTimeButton]
        
        for button in buttonsArray {
            button!.layer.masksToBounds = false
            button!.layer.shadowOffset = CGSize(width: 0, height: 0)
            button!.layer.shadowOpacity = 0.28
            button!.layer.shadowRadius = 8
        }

        self.navigationController?.navigationBar.isHidden = true
        let graphImage : UIImage? = UIImage(named: "graphImage.png")
        graphImageView.image = graphImage
        
        generateRidesPerWeekButtonMenus()
        generatePrferredTimeButtonMenus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 기본 정보
        nameValueLabel.text = UserModel.shared.name

        genderAgeLocationValueLabel.text = "\(UserModel.shared.gender.rawValue)  \(UserModel.shared.age)  \(UserModel.shared.location.rawValue)"

        // 선호 환경
        preferredEnvironmentValueLabel.text = UserModel.shared.prefer_space.rawValue

        refreshButtonClicked(refreshButton)
    }
    
    
    // MARK: - Refresh Button
    
    @IBAction func refreshButtonClicked(_ sender: Any) {
//    @IBAction func refreshButtonClicked() {
        // 평균 속도, 최고 속도, 평균 거리, 전체 거리 표시
        averageSpeedValueLabel.text = String(UserModel.shared.averageSpeed)
        maxSpeedValueLabel.text = String(UserModel.shared.maxSpeed)
        averageDistanceValueLabel.text = String(UserModel.shared.averageDistance)
        totalDistanceValueLabel.text = String(UserModel.shared.totalDistance)
    }
    
    
    // MARK: - Generating Button Menus for Rides Per Week
    // 주 라이딩 횟수 버튼 메뉴 생성

    func generateRidesPerWeekButtonMenus() {
        var menus = [UIAction]()
        
        let ridesPerWeekArray = [How_often.oneToTwo, How_often.threeToFour, How_often.moreThanFive]
        var index = 0
        
        for ridesPerWeek in ridesPerWeekArray {
            if ridesPerWeek == UserModel.shared.how_often {
                menus.append(UIAction(title: ridesPerWeek.rawValue, state: .on) { _ in })
            } else {
                menus.append(UIAction(title: ridesPerWeek.rawValue, state: .off) { _ in
                    UserDatabaseManager.shared.editUserHowOften(to: ridesPerWeek)
                })
            }
            index += 1
        }
        
        
        // Attach submenus to the menu button
        ridesPerWeekValueButton.menu = UIMenu(title: "선택", identifier: nil, options: .displayInline, children: menus)
        ridesPerWeekValueButton.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            ridesPerWeekValueButton.changesSelectionAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    // MARK: - Generating Button Menus for Preferred Time
    // 선호 시간대 버튼 메뉴 생성

    func generatePrferredTimeButtonMenus() {
        var menus = [UIAction]()
      
        let preferredTimeArray = [Prefer_time.morning, Prefer_time.midday, Prefer_time.afternoon, Prefer_time.evening, Prefer_time.night, Prefer_time.midnight, Prefer_time.dawn, Prefer_time.dawn_morning]
        var index = 0
        
        for preferredTime in preferredTimeArray {
            if preferredTime == UserModel.shared.prefer_time {
                menus.append(UIAction(title: preferredTime.rawValue, state: .on) { _ in  })
            } else {
                menus.append(UIAction(title: preferredTime.rawValue, state: .off) { _ in
                    UserDatabaseManager.shared.editUserPreferTime(to: preferredTime)  })
            }
            index += 1
        }
    
        
        // Attach submenus to the menu button
        preferredTimeValueButton.menu = UIMenu(title: "선택", identifier: nil, options: .displayInline, children: menus)
        preferredTimeValueButton.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            preferredTimeValueButton.changesSelectionAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    // MARK: - View Change Functions
    // 뷰 전환
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        guard let signInViewController = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewController(withIdentifier: "signinVC") as? SignInViewController else { fatalError() }
        
        self.navigationController?.pushViewController(signInViewController, animated: true)
    }

    
    @IBAction func editBasicProfileButtonClicked(_ sender: Any) {
        guard let editBasicProfileViewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "editbasicprofileVC") as? EditBasicProfileViewController else { fatalError() }
        
        self.navigationController?.pushViewController(editBasicProfileViewController, animated: true)
    }
    
    
    @IBAction func cyclingDistanceAndDurationChartViewButtonClicked(_ sender: Any) {
        guard let chartViewController = UIStoryboard(name: "Chart", bundle: nil).instantiateViewController(withIdentifier: "chartVC") as? MobilityChartDataViewController else { fatalError() }
        
        self.navigationController?.pushViewController(chartViewController, animated: true)
    }
    
    
    @IBAction func preferredenvironmentViewButtonClicked(_ sender: Any) {
        guard let preferredEnvironmentViewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "preferredenvironmentVC") as? PreferredEnvironmentViewController else { fatalError() }
        
        self.navigationController?.pushViewController(preferredEnvironmentViewController, animated: true)
    }

}


