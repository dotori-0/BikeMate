//
//  GroupModel.swift
//  Bikemate
//
//  Created by new on 2022/02/23.
//

import Firebase

class GroupModel {
    
    var key: String = ""
    var count: Int = 0
    //var boardId : String = "" // 그룹 배정 후 해당 board 지정 ?
    
    
    //사용자 정보
    var age: ageT?
    var gender: Gender?
    var location: Location?// 선호 지역구
    var averageTime: AverageTime?
    var averageSpeed: AverageSpeed?
    var averageDistance: AverageDistance?
    var prefer_space: Prefer_space? // 주행 선호 장소
    var prefer_time: Prefer_time? // 주행 선호 시간대
    var how_often: How_often? // 주 라이딩 횟수
    
    
    func storeGroupInDatabase() {
        
        if let age = age {
            key = "\(age.rawValue)"

        }
        
        if let gender = gender {
            key = "\(key)\(gender.rawValue)"
        }
        
        if let location = location {
            key = "\(key)\(location.rawValue)"
        }
        
        if let averageTime = averageTime {
            key = [key, averageTime.rawValue].joined()
        }
        
        if let averageSpeed = averageSpeed {
            key = [key, averageSpeed.rawValue].joined()
        }
        
        if let averageDistance = averageDistance {
            key = [key, averageDistance.rawValue].joined()
        }
        
        if let prefer_space = prefer_space {
            key = [key, prefer_space.rawValue].joined()
        }
        
        if let prefer_time = prefer_time {
            key = [key, prefer_time.rawValue].joined()
        }
        
        if let how_often = how_often {
            key = [key, how_often.rawValue].joined()
        }
        
        if let age = age {
            Database.database().reference().child("Group").child(key).child("age").setValue(self.age!.rawValue)

        }
        
        if let gender = gender {
            Database.database().reference().child("Group").child(key).child("gender").setValue(self.gender!.rawValue)

        }
        
        if let location = location {
            Database.database().reference().child("Group").child(key).child("location").setValue(self.location!.rawValue)
        }
        
        if let averageTime = averageTime {
            Database.database().reference().child("Group").child(key).child("averageTime").setValue(self.averageTime!.rawValue)
        }
        
        if let averageSpeed = averageSpeed {
            Database.database().reference().child("Group").child(key).child("averageSpeed").setValue(self.averageSpeed!.rawValue)
        }
        
        if let averageDistance = averageDistance {
            Database.database().reference().child("Group").child(key).child("averageDistance").setValue(self.averageDistance!.rawValue)

        }
        
        if let prefer_space = prefer_space {
            Database.database().reference().child("Group").child(key).child("preferSpace").setValue(self.prefer_space!.rawValue)
        }
        
        if let prefer_time = prefer_time {
            Database.database().reference().child("Group").child(key).child("preferTime").setValue(self.prefer_time!.rawValue)
        }
        
        
        if let how_often = how_often {
            Database.database().reference().child("Group").child(key).child("howOften").setValue(self.how_often!.rawValue)
        }
        
        
        GroupManager.shared.groupArray.append(self)
        GroupManager.shared.recommendedGroupArray.append(self)
    }
    
    
    
    
    
    
    
    
    

    
}

enum ageT: String, CaseIterable  {
    case twenty = "20대"
    case thirty = "30대"
    case fourty = "40대"
    case fifty = "50대"
    case sixty = "60대"
}

enum AverageTime: String, CaseIterable {
    case one = "24분 미만"
    case two = "24분~40분"
    case three = "40분~101분"
    case four = "101분 이상"
}

enum AverageSpeed: String, CaseIterable {
    case one = "18km/h 미만"
    case two = "18~21km/h"
    case three = "21~23km/h"
    case four = "23km/h 이상"
}

enum AverageDistance: String, CaseIterable {
    case one = "7km 미만"
    case two = "7km~14km"
    case three = "14km~35km"
    case four = "35km 이상"
}

//1440s 24분
//1440s-2415s 24-40분
//2415s-6099s 40분-101분
//6099s

//7.451km
//7.451km - 13.702km
//13.702km - 34.599km
//34.599km
