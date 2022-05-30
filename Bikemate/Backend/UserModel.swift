//
//  UserModel.swift
//  FirebaseTest
//
//  Created by new on 2022/02/18.
//

import ObjectMapper
import HealthKit

class UserModel: Mappable {

    static let shared = UserModel()

    var email: String = ""
    var name: String = ""
    var uid: String = "testtest"
    var groupid: String? // 사용자가 그룹 추천을 받을 경우 해당 그룹 id 부여.
    var age: Int = 20
    var gender: Gender = .f
    var location: Location = .Gangnam // 선호 지역구
    var prefer_space: Prefer_space = .river // 주행 선호 장소
    var how_often: How_often = .oneToTwo // 주 라이딩 횟수
    var prefer_time: Prefer_time = .morning // 주행 선호 시간대
    
    // for healthkit data
    var time: Double = 1 // 분
    var distance: Double = 20 // 미터
    
    
    var totalDistance: Double = 0
    var averageDistance: Double = 0
    var averageTime: Double = 0
    var averageSpeed: Double = 0
    var maxSpeed: Double = 0

    let healthStore = HKHealthStore()
    private init() {
        
        // 폰 업데이트 후 폰에 빌드해보기
        // request()
        
    }
    
    
    private func request() {
        let allTypes = Set([HKObjectType.workoutType(),
                            HKObjectType.quantityType(forIdentifier: .distanceCycling)!])

        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if !success {
                // Handle the error here
                print(error)
            } else {
                
            }
        }
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        email <- map["email"]
        name <- map["name"]
        uid <- map["uid"]
        age <- map["age"]
        gender <- map["gender"]
        location <- map["location"]
        prefer_space <- map["prefer_space"]
        how_often <- map["how_often"]
        prefer_time <- map["prefer_time"]
        averageTime <- map["averageTime"]
        averageSpeed <- map["averageSpeed"]
        averageDistance <- map["averageDistance"]
    }
}

enum Gender: String, CaseIterable {
    case f = "여성"
    case m = "남성"
}

enum Location: String, CaseIterable {
    case Gangnam = "강남구"
    case Gangdong = "강동구"
    case Gangbuk = "강북구"
    case Gangseo = "강서구"
    case Gwanak = "관악구"
    case Gwangjin = "광진구"
    case Guro = "구로구"
    case Geumcheon = "금천구"
    case Nowon = "노원구"
    case Dobong = "도봉구"
    case Dongdaemun = "동대문구"
    case Dongjak = "동작구"
    case Mapo = "마포구"
    case Seodaemun = "서대문구"
    case Seocho = "서초구"
    case Seongdong = "성동구"
    case Seongbuk = "성북구"
    case Songpa = "송파구"
    case Yangcheon = "양천구"
    case Yeongdeungpo = "영등포구"
    case Yongsan = "용산구"
    case Eunpyeong = "은평구"
    case Jongno = "종로구"
    case Jung = "중구"
    case Jungnang = "중랑구"
}

enum Prefer_space: String, CaseIterable {
    case city_road = "도심"
    case river = "강변"
    case mountain = "산"
    case park = "공원"
}

enum How_often: String, CaseIterable {
    case oneToTwo = "주 1-2 회"
    case threeToFour = "주 3-4 회"
    case moreThanFive = "주 5 회 이상"
}

enum Prefer_time: String, CaseIterable {
    case morning = "06-09 시"
    case midday = "09-12 시"
    case afternoon = "12-15 시"
    case evening = "15-18 시"
    case night = "18-21 시"
    case midnight = "21-24 시"
    case dawn = "00-03 시"
    case dawn_morning = "03-06 시"
}
