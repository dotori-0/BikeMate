//
//  CyclingManager.swift
//  Bikemate
//
//  Created by new on 2022/03/08.
//

import Foundation
import Firebase
import FirebaseDatabase

class CyclingManager {
     
    private let rootRef = Database.database().reference()
    
    static let shared = CyclingManager()
    
    //var arr: [UserModel] = []
    
    
    private init() {

        }
    
    
    func getHealthKitDataAndSetInfo(time: [Double], distance: [Double]) {

        
        let totalTime = (time.reduce(0, +))/60
      
        UserModel.shared.averageTime = Double(Int(round(totalTime/Double(time.count))))
        
        let totalDistance = (distance.reduce(0, +))/1000
        
        UserModel.shared.totalDistance = Double(Int(round(totalDistance)))
      
        UserModel.shared.averageDistance = round(totalDistance/Double(distance.count))
        
        var maxSpeed: Double = 0
        // var maxSpeedList: [Double] = []
        
        for i in 0..<min(time.count, distance.count) {
            
            let distanceKm = Double(distance[i]/1000)
            let timeHour = Double(time[i]/60)
            
            let speed = Double(distanceKm / timeHour)
            
            print("distanceKm \(i): \(distanceKm)")
            print("time \(i): \(time[i])")
            print("timeHour \(i): \(timeHour)")
            print("speed \(i): \(speed)")
            
            maxSpeed = max(speed, maxSpeed)
        }
       
        
        UserModel.shared.maxSpeed = Double(Int(round(maxSpeed*10)))/10
        
        
        let temp = totalDistance/totalTime
        
        UserModel.shared.averageSpeed = Double(Int(round(temp*10)))/10

        
        
        //db 저장 하는 함수
        
        rootRef.child("User").child(UserModel.shared.uid).child("averageTime").setValue(UserModel.shared.averageTime)
        rootRef.child("User").child(UserModel.shared.uid).child("totalDistance").setValue(UserModel.shared.totalDistance)
        rootRef.child("User").child(UserModel.shared.uid).child("averageDistance").setValue(UserModel.shared.averageDistance)
        rootRef.child("User").child(UserModel.shared.uid).child("averageSpeed").setValue(UserModel.shared.averageSpeed)
        

    }
    
    
}
