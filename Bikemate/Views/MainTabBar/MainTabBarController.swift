//
//  MainTabBarController.swift
//  Bikemate
//
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let profileSB = UIStoryboard(name: "Profile", bundle: nil)
        let profileVC = profileSB.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
        profileVC.tabBarItem = UITabBarItem(title: nil,
                                            image: UIImage(systemName: "house"),
                                            selectedImage: UIImage(systemName: "house"))
        
        let bikeRoadSB = UIStoryboard(name: "BikeRoad", bundle: nil)
        let bikeRoadVC = bikeRoadSB.instantiateViewController(withIdentifier: "bikeroadVC") as! BikeRoadViewController
        
        bikeRoadVC.tabBarItem = UITabBarItem(title: nil,
                                            image: UIImage(systemName: "map"),
                                            selectedImage: UIImage(systemName: "map"))
        
        
        let bikeMapSB = UIStoryboard(name: "Bikemap", bundle: nil)
        let bikeMapVC = bikeMapSB.instantiateViewController(withIdentifier: "bikemapVC") as! BikemapViewController
        
        bikeMapVC.tabBarItem = UITabBarItem(title: nil,
                                            image: UIImage(systemName: "bicycle"),
                                            selectedImage: UIImage(systemName: "bicycle"))
        
        
        let groupSB = UIStoryboard(name: "Group", bundle: nil)
        
        if UserModel.shared.groupid != nil {
            let communitymainVC = groupSB.instantiateViewController(withIdentifier: "groupcommunitymainVC") as! GroupCommunityMainViewController
            communitymainVC.tabBarItem = UITabBarItem(title: nil,
                                             image: UIImage(systemName: "person.3"),
                                            selectedImage: UIImage(systemName: "person.3"))
            
            viewControllers = [ UINavigationController(rootViewController: profileVC), UINavigationController(rootViewController: bikeRoadVC), UINavigationController(rootViewController: bikeMapVC) , UINavigationController(rootViewController: communitymainVC)]
            
            [   profileVC,
                bikeRoadVC,
                bikeMapVC,
                communitymainVC ].forEach { $0?.tabBarItem.imageInsets = UIEdgeInsets.init(top: 10,left: 0,bottom: -5,right: 0) }

        } else {
            let beforegroupingVC  = groupSB.instantiateViewController(withIdentifier: "beforegroupingVC") as! BeforeGroupingViewController
            beforegroupingVC.tabBarItem = UITabBarItem(title: nil,
                                             image: UIImage(systemName: "person.3"),
                                            selectedImage: UIImage(systemName: "person.3"))
            
            viewControllers = [ UINavigationController(rootViewController: profileVC), UINavigationController(rootViewController: bikeRoadVC), UINavigationController(rootViewController: bikeMapVC) , UINavigationController(rootViewController: beforegroupingVC)]
            
            [   profileVC,
                bikeRoadVC,
                bikeMapVC,
                beforegroupingVC ].forEach { $0?.tabBarItem.imageInsets = UIEdgeInsets.init(top: 10,left: 0,bottom: -5,right: 0) }

        }
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }
}
