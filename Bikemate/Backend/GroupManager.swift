//
//  GroupManager.swift
//  Bikemate
//
//  Created by new on 2022/02/23.
//

import Firebase
import FirebaseDatabase

class GroupManager {
     
    private let rootRef = Database.database().reference()
    
    static let shared = GroupManager()
    
    var groupArray: [GroupModel] = []
    
    var recommendedGroupArray: [GroupModel] = []
    
    
    private init() {
        
        self.getAllGroups { groupArray in
            self.groupArray = groupArray
        }
        
    }
    
    /* 전체 그룹 추출 */
    func getAllGroups(completion: @escaping (Array<GroupModel>) -> ()){
        
        rootRef.child("Group").observeSingleEvent(of: .value, with: { snapshot in
            
            var groups: Array<GroupModel> = Array<GroupModel>()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let key = child.key
                let item = child.value as? [String: Any]
                                
                let age = item?["age"] as? String ?? "20대"
                let gender = item?["gender"] as? String ?? "여성"
                let location = item?["location"] as? String ?? "강남구"
                let averageTime = item?["averageTime"] as? String ?? "24분 미만"
                let averageSpeed = item?["averageSpeed"] as? String ?? "18km/h 미만"
                let averageDitance = item?["averageDitance"] as? String ?? "7km 미만"
                let prefer_space = item?["prefer_space"] as? String ?? "도심"
                let prefer_time = item?["prefer_time"] as? String ?? "06-09 시"
                let how_often = item?["how_often"] as? String ?? "주 1-2 회"
                

                
                let groupModel = GroupModel()
                
                groupModel.age = ageT(rawValue: age)
                groupModel.gender = Gender(rawValue: gender)
                groupModel.location = Location(rawValue: location)
                groupModel.averageTime = AverageTime(rawValue: averageTime)
                groupModel.averageSpeed = AverageSpeed(rawValue: averageSpeed)
                groupModel.averageDistance = AverageDistance(rawValue: averageDitance)
                groupModel.prefer_space = Prefer_space(rawValue: prefer_space)
                groupModel.prefer_time = Prefer_time(rawValue: prefer_time)
                groupModel.how_often = How_often(rawValue: how_often)
                groupModel.key = key
              
                groups.append(groupModel)
                
            }
            completion(groups)
        })
    }
    
    
    
    /* 추천 그룹 조희 */
    func getGroup(key: String) -> GroupModel {
        return self.groupArray.filter { $0.key == key}.first!
    }
    
    func registerInGroup(groupModel: GroupModel) {
        //Group에 추가
        rootRef.child("Group").child(groupModel.key).child("Users").child(UserModel.shared.uid).setValue(UserModel.shared.uid)

        //User에 추가
        rootRef.child("User").child(UserModel.shared.uid).child("groupId").setValue(groupModel.key)
        
        
    }
    
    func getGroupUserList(groupModel: GroupModel) -> [OtherUserModel] {
        var groupUserArray = [OtherUserModel]()
        
        for user in UserDatabaseManager.shared.userArray {
            if user.groupId == groupModel.key {
                groupUserArray.append(user)
            }
        }
        
        
        return groupUserArray
    }
    
    func getGroupUserCount(groupModel: GroupModel) -> Int {
        
        var groupUserArray = [OtherUserModel]()
        
        for user in UserDatabaseManager.shared.userArray {
            if user.groupId == groupModel.key {
                groupUserArray.append(user)
            }
        }
        
        return groupUserArray.count
    }
    
}

