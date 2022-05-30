//
//  CyclingModel.swift
//  Bikemate
//
//  Created by new on 2022/03/08.
//

import Foundation
import HealthKit

// healthkit 추출 데이터


class CyclingModel {
    
    static let shared = CyclingModel()
    
    public let uid: String?
    public var time: Int = 0
    public var distance: Int = 0
    public var speed: Int = 0

    public var averageDistance: Int = 0
    public var averageTime: Int = 0
    public var averageSpeed: Int = 0

    private init() {
        uid = ""
    }

}
