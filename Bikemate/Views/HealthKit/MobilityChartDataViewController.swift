//
//  MobilityChartDataViewController.swift
//  Bikemate
//
//


import UIKit
import HealthKit

class MobilityChartDataViewController: DataTypeCollectionViewController {
    
    let calendar: Calendar = .current
    
    var mobilityContent: [String] = [
        HKQuantityTypeIdentifier.distanceCycling.rawValue,
        HKQuantityTypeIdentifier.appleExerciseTime.rawValue
    ]
    
    var queries: [HKAnchoredObjectQuery] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = mobilityContent.map { ($0, []) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Authorization
        if !queries.isEmpty { return }
        
        HealthData.requestHealthDataAccessIfNeeded(dataTypes: mobilityContent) { (success) in
            if success {
                self.setUpBackgroundObservers()
                self.loadData()
            }
        }
    }
    
    // MARK: - Data Functions
    
    func loadData() {
        performQuery {
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
            }
        }
    }
    
    func setUpBackgroundObservers() {
        data.compactMap { getSampleType(for: $0.dataTypeIdentifier) }.forEach { (sampleType) in
            createAnchoredObjectQuery(for: sampleType)
        }
    }
    
    func createAnchoredObjectQuery(for sampleType: HKSampleType) {
        // Customize query parameters
        let predicate = createLastWeekPredicate()
        let limit = HKObjectQueryNoLimit
        
        // Fetch anchor persisted in memory
        let anchor = HealthData.getAnchor(for: sampleType)
        
        // Create HKAnchoredObjecyQuery
        let query = HKAnchoredObjectQuery(type: sampleType, predicate: predicate, anchor: anchor, limit: limit) {
            (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
            
            // Handle error
            if let error = errorOrNil {
                print("HKAnchoredObjectQuery initialResultsHandler with identifier \(sampleType.identifier) error: \(error.localizedDescription)")
                
                return
            }
            
            print("HKAnchoredObjectQuery initialResultsHandler has returned for \(sampleType.identifier)!")
            
            // Update anchor for sample type
            HealthData.updateAnchor(newAnchor, from: query)
        }
        
        // Create update handler for long-running background query
        query.updateHandler = { (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
            
            // Handle error
            if let error = errorOrNil {
                print("HKAnchoredObjectQuery initialResultsHandler with identifier \(sampleType.identifier) error: \(error.localizedDescription)")
                
                return
            }
            
            print("HKAnchoredObjectQuery initialResultsHandler has returned for \(sampleType.identifier)!")
            
            // Update anchor for sample type
            HealthData.updateAnchor(newAnchor, from: query)
        }
        
        HealthData.healthStore.execute(query)
        queries.append(query)
    }
    
    // MARK: - Data Functions
    
    var times = [Double]()
    var distances = [Double]()
    
    func performQuery(completion: @escaping () -> Void) {
        // Create a query for each data type.
        for (index, item) in data.enumerated() {
            // Set dates
            let now = Date()
            let startDate = getLastWeekStartDate()
            let endDate = now
            
            let predicate = createLastWeekPredicate()
            let dateInterval = DateComponents(day: 1)
            
            // Process data
            let statisticsOptions = getStatisticsOptions(for: item.dataTypeIdentifier)
            let initialResultsHandler: (HKStatisticsCollection) -> Void = { (statisticsCollection) in
                var values: [Double] = []
                
                statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
                    let statisticsQuantity = getStatisticsQuantity(for: statistics, with: statisticsOptions)
                    if let unit = preferredUnit(for: item.dataTypeIdentifier),
                        let value = statisticsQuantity?.doubleValue(for: unit) {
                        values.append(value)
                    }
                }
                
                self.data[index].values = values
                
                if item.dataTypeIdentifier == HKQuantityTypeIdentifier.distanceCycling.rawValue {
                    self.distances = values
                } else {
                    self.times = values
                    
                    CyclingManager.shared.getHealthKitDataAndSetInfo(time: self.times, distance: self.distances)
                }
                
                completion()
            }
            
            // Fetch statistics
            HealthData.fetchStatistics(with: HKQuantityTypeIdentifier(rawValue: item.dataTypeIdentifier),
                                       predicate: predicate,
                                       options: statisticsOptions,
                                       startDate: startDate,
                                       interval: dateInterval,
                                       completion: initialResultsHandler)
        }
    }
}
