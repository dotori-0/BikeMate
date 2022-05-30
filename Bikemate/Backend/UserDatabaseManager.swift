//
//  UserDatabaseManager.swift
//  Bikemate
//
//  Created by new on 2022/02/20.
//

import Firebase

class UserDatabaseManager {
    static let shared = UserDatabaseManager()
    
    var userArray: [OtherUserModel] = []
    
    private let rootRef = Database.database().reference()
    
    private init() {
        self.getAllUsers { userModelArray in
            self.userArray = userModelArray
        }
    }
    
    
    
    func getAllUsers(completion: @escaping (Array<OtherUserModel>) -> ()){
        
        rootRef.child("User").observeSingleEvent(of: .value, with: { snapshot in
            var otherUserModels: Array<OtherUserModel> = Array<OtherUserModel>()
            for child in snapshot.children {
                let dataSnapshot = child as? DataSnapshot
                let item = dataSnapshot?.value as? NSDictionary
                                
                let uid = dataSnapshot?.key ?? ""
                let email = item?["email"] as? String ?? ""
                let name = item?["name"] as? String ?? ""
                let age = item?["age"] as? Int ?? 20
                let gender = item?["gender"] as? String ?? "여성"
                let changedGender = Gender(rawValue: gender)
                let location = item?["location"] as? String ?? "강남구"
                let changedLocation = Location(rawValue: location)
                let prefer_space = item?["prefer_space"] as? String ?? "도심"
                let changed_prefer_space = Prefer_space(rawValue: prefer_space)
                let how_often = item?["how_often"] as? String ?? "주 1-2 회"
                let changed_how_often = How_often(rawValue: how_often)
                let prefer_time = item?["prefer_time"] as? String ?? "06-09 시"
                let changed_prefer_time = Prefer_time(rawValue: prefer_time)
                let groupId = item?["groupId"] as? String
                
                let time = item?["time"] as? Double ?? 1.0
                let distance = item?["distance"] as? Double ?? 20
                let totalDistance = item?["totalDistance"] as? Int ?? 10
                let averageDistance = item?["averageDistance"] as? Double ?? 0
                let averageTime = item?["averageTime"] as? Int ?? 0
                let averageSpeed = item?["averageSpeed"] as? Double ?? 0
                let maxSpeed = item?["maxSpeed"] as? Double ?? 0
                


                let otherUserModel = OtherUserModel(email: email, name: name, uid: uid, age: age, gender: changedGender!, location: changedLocation!, prefer_space: changed_prefer_space!, how_often: changed_how_often!, prefer_time: changed_prefer_time!, boardIds: [], groupId: groupId, time: time, distance: distance, totalDistance: totalDistance, averageDistance: averageDistance, averageTime: averageTime, averageSpeed: averageSpeed, maxSpeed: maxSpeed)
                
                otherUserModels.append(otherUserModel)
            }
            completion(otherUserModels)
        })
    }
    
    
    func editUserAge(to age: Int) {
        UserModel.shared.age = age
        rootRef.child("User").child(UserModel.shared.uid).child("age").setValue(age)
    }
    
    func editUserName(to name: String) {
        UserModel.shared.name = name
        rootRef.child("User").child(UserModel.shared.uid).child("name").setValue(name)
    }
    
    func editUserDistrict(to location: Location) {
        UserModel.shared.location = location
        rootRef.child("User").child(UserModel.shared.uid).child("location").setValue(location.rawValue)
    }
    
    
    func editUserPreferSpace(to prefer_space: Prefer_space) {
        UserModel.shared.prefer_space = prefer_space
        rootRef.child("User").child(UserModel.shared.uid).child("prefer_space").setValue(prefer_space.rawValue)
    }
    
    func editUserPreferTime(to prefer_time: Prefer_time) {
        UserModel.shared.prefer_time = prefer_time
        rootRef.child("User").child(UserModel.shared.uid).child("prefer_time").setValue(prefer_time.rawValue)
    }
    
    func editUserHowOften(to how_often: How_often) {
        UserModel.shared.how_often = how_often
        rootRef.child("User").child(UserModel.shared.uid).child("how_often").setValue(how_often.rawValue)
    }
    
    
    func getUserByUid(uid: String) -> OtherUserModel {
        return self.userArray.filter{ $0.uid == uid }.first!
    }
}
