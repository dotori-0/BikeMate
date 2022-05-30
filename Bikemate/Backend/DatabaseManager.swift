//
//  DatabaseManager.swift
//  Bikemate
//
//  Created by 박진서 on 2022/01/23.
//

import FirebaseAuth
import FirebaseDatabase

class DatabaseManager {
    
    private let ref = Database.database().reference()
    
    static let shared = DatabaseManager()  //규칙 1
    
    private init() {
    } //규칙 2
    
    func login(email: String, password: String, loginSucceeded: (() -> Void)?, loginFailed: (() -> Void)?)
    {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Login Error : \(error)")
                loginFailed!()
            } else {
                //MARK: Todo DB에서 정보 가져오기
                
                print("Login 성공")
                self.ref.child("User").child(authResult!.user.uid).observeSingleEvent(of: .value) { DataSnapshot in
                    
                    let value = DataSnapshot.value as! [String: Any]
                    let userModel = UserModel.shared
                    userModel.name = value["name"] as! String
                    userModel.email = value["email"] as! String
                    userModel.prefer_time = Prefer_time(rawValue: (value["prefer_time"] as! String))!
                    userModel.age = value["age"] as! Int
                    userModel.gender = Gender(rawValue: (value["gender"] as! String))!
                    userModel.how_often = How_often(rawValue: (value["how_often"] as! String))!
                    userModel.prefer_space = Prefer_space(rawValue: (value["prefer_space"] as! String))!
                    userModel.location = Location(rawValue: (value["location"] as! String))!
                    userModel.uid = value["uid"] as! String
                    userModel.groupid = value["groupId"] as? String
                    let averageTime = value["averageTime"] as? Int ?? 0
                    let averageSpeed = value["averageSpeed"] as? Double ?? 0
                    let averageDistance = value["averageDistance"] as? Double ?? 0
                    let totalDistance = value["totalDistance"] as? Double ?? 0
                    
                    userModel.averageTime = Double(averageTime)
                    userModel.averageSpeed = averageSpeed
                    userModel.averageDistance = Double(averageDistance)
                    userModel.totalDistance = Double(totalDistance)
                    
                    loginSucceeded!()

                    
                }
                
            }
        }
    }
    
    
    func signUp(email: String, password: String, name: String, age: Int, gender: Gender, location: Location, prefer_space: Prefer_space, how_often: How_often, prefer_time: Prefer_time, signInSucceeded: (() -> Void)?, signInFailed: (() -> Void)?)
    {
        
        Auth.auth().createUser(withEmail: email, password: password) {
            
            authResult, error in
            
            if let error = error {
                print("SignUp Error : \(error)")
                signInFailed!()

            } else {
                //MARK: Todo DB에 정보 저장
                self.ref.child("User").child(authResult!.user.uid).setValue(["email": email, "name": name,"age": age, "gender": gender.rawValue,  "location": location.rawValue, "prefer_space": prefer_space.rawValue, "how_often": how_often.rawValue,"prefer_time": prefer_time.rawValue, "uid": authResult!.user.uid])
                
                

                signInSucceeded!()
            }
        }
    }
    

}
