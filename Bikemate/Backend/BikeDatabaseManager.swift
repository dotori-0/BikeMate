//
//  BikeDatabaseManager.swift
//  Bikemate
//
//  Created by 박진서 on 2022/02/23.
//

import Alamofire

// MARK: - BikeDataEntity
struct BikeDataEntity: Codable {
    let rentBikeStatus: RentBikeStatus
}

// MARK: - RentBikeStatus
struct RentBikeStatus: Codable {
    let listTotalCount: Int
    let result: Result
    let bikeStationDataArray: [BikeStationData]

    enum CodingKeys: String, CodingKey {
        case listTotalCount = "list_total_count"
        case result = "RESULT"
        case bikeStationDataArray = "row"
    }
}

// MARK: - Result
struct Result: Codable {
    let code, message: String?

    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
}

// MARK: - Row
struct BikeStationData: Codable {
    let rackTotCnt, stationName, parkingBikeTotCnt, shared: String
    let stationLatitude, stationLongitude, stationID: String

    enum CodingKeys: String, CodingKey {
        case rackTotCnt, stationName, parkingBikeTotCnt, shared, stationLatitude, stationLongitude
        case stationID = "stationId"
    }
}


class BikeDatabaseManager {
    static let shared = BikeDatabaseManager()
    let baseUrlString = "http://openapi.seoul.go.kr:8088/6749445a73686a6739305678664c52/json/bikeList/1/1000"
    var baseUrl: URL?
    
    var bikeStationDataArray = [BikeStationData]()
    
    private init() {
        
        if let baseUrl = URL(string: baseUrlString) {
            self.baseUrl = baseUrl
        } else {
            print("🚫 [Bike DB] URL 파싱 에러")
            self.baseUrl = nil
        }

        var request = URLRequest(url: baseUrl!)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10

        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                print("🆗 [Bike DB - fetchAll] Fetching 성공")
                let bikeDataEntity = try! JSONDecoder().decode(BikeDataEntity.self, from: data)
                self.bikeStationDataArray = bikeDataEntity.rentBikeStatus.bikeStationDataArray
                print(self.bikeStationDataArray.count)
            case .failure(let error):
                print("🚫 [Bike DB - fetchAll] Fetching 실패 !:\(error._code), Message: \(error.errorDescription!)")
            }
        }




//
//        //   let bikeDataEntity = try? newJSONDecoder().decode(BikeDataEntity.self, from: jsonData)

   
    }
    
    
    
  
    
}
