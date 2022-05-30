//
//  HealthKitSupport+Strings.swift
//  Bikemate
//
//


import Foundation
import HealthKit

// MARK: - Data Type Strings

func getDataTypeName(for identifier: String) -> String? {
    var description: String?
    let sampleType = getSampleType(for: identifier)
    
    if sampleType is HKQuantityType {
        let quantityTypeIdentifier = HKQuantityTypeIdentifier(rawValue: identifier)
        
        switch quantityTypeIdentifier {
        case .distanceCycling:
            description = "주행 거리"
        case .appleExerciseTime:
            description = "주행 시간"
        default:
            break
        }
    }
    
    return description
}

// MARK: - Formatted Value Strings

func formattedValue(_ value: Double, typeIdentifier: String) -> String? {
    guard
        let unit = preferredUnit(for: typeIdentifier),
        let roundedValue = getRoundedValue(for: value, with: unit),
        let unitSuffix = getUnitSuffix(for: unit)
    else {
        return nil
    }
    
    let formattedString = String.localizedStringWithFormat("%@ %@", roundedValue, unitSuffix)
    
    return formattedString
}

private func getRoundedValue(for value: Double, with unit: HKUnit) -> String? {
    let numberFormatter = NumberFormatter()
    
    numberFormatter.numberStyle = .decimal
    
    switch unit {
    case .meter():
        let numberValue = NSNumber(value: round(value))
        
        return numberFormatter.string(from: numberValue)
    default:
        return nil
    }
}

// MARK: - Unit Strings

func getUnitDescription(for unit: HKUnit) -> String? {
    switch unit {
    case .meter():
        return "meters"
    case .minute():
        return "minutes"
    default:
        return nil
    }
}

private func getUnitSuffix(for unit: HKUnit) -> String? {
    switch unit {
    case .meter():
        return "m"
    case .minute():
        return "mins"
    default:
        return nil
    }
}

