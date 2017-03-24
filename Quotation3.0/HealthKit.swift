//
//  HealthKit.swift
//  Alice
//
//  Created by Dariusz Łuksza on 24/03/2017.
//  Copyright © 2017 QD Team. All rights reserved.
//

import Foundation
import HealthKit

class HealthKit {
  fileprivate let store: HKHealthStore

  init() {
    self.store = HKHealthStore()
  }

  func authorize(callback: @escaping (Bool) -> Void) {
    let toRead = Set(arrayLiteral:
      HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!,
      HKObjectType.characteristicType(forIdentifier: .bloodType)!,
      HKObjectType.characteristicType(forIdentifier: .biologicalSex)!,
      HKObjectType.characteristicType(forIdentifier: .fitzpatrickSkinType)!,
      HKObjectType.quantityType(forIdentifier: .bodyMass)!,
      HKObjectType.quantityType(forIdentifier: .height)!,
      HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
      HKObjectType.quantityType(forIdentifier: .bodyFatPercentage)!,
      HKObjectType.quantityType(forIdentifier: .bodyTemperature)!,
      HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
      HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
      HKObjectType.quantityType(forIdentifier: .distanceSwimming)!,
      HKObjectType.quantityType(forIdentifier: .distanceWheelchair)!,
      HKObjectType.quantityType(forIdentifier: .heartRate)!,
      HKObjectType.quantityType(forIdentifier: .respiratoryRate)!,
      HKObjectType.quantityType(forIdentifier: .stepCount)!,
      HKObjectType.workoutType(),
      HKObjectType.activitySummaryType())
    self.store.requestAuthorization(toShare: nil, read: toRead, completion: {
      status, error in
      callback(error == nil && status)
    })
  }

  func height(callback: @escaping (HKSample?, Error?) -> Void) {
    self.query(typeIndentifier: .height, limit: 1, operation: {
      results, error in
      if let e = error {
        callback(nil, e)
      } else if results.count > 0 {
        callback(results.first, nil)
      } else {
        callback(nil, nil)
      }
    })
  }

  func bloodType() throws -> DateComponents {
    return try self.store.dateOfBirthComponents()
  }

  func biologicalSex() throws -> HKBiologicalSex {
    return try self.store.biologicalSex().biologicalSex
  }

  func skinType() throws -> HKFitzpatrickSkinType {
    return try self.store.fitzpatrickSkinType().skinType
  }

  func avarageBodyMass(callback: @escaping (Double?, Error?) -> Void) {
    self.query(typeIndentifier: .bodyMass, limit: Int.max, operation: {
      results, error in
      if let e = error {
        callback(nil, e)
      } else if results.count > 0 {
        let weights = results
          .map({
            sample -> Double in
            if let s = sample as? HKQuantitySample {
              return s.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            }
            return 0
          })
          .filter({ return $0 > 0})

        let avg = weights.reduce(0, { return $0 + $1 }) / Double(weights.count)
        callback(avg, nil)
      } else {
        callback(nil, nil)
      }
    })
  }

  fileprivate func query(typeIndentifier: HKQuantityTypeIdentifier,
                         limit: Int,
                         operation: @escaping ([HKSample], Error?) -> Void) {
    let distantPastHeight = NSDate.distantPast
    let currentDate = Date()
    let lastHeightPredicate = HKQuery.predicateForSamples(withStart: distantPastHeight,
                                                          end: currentDate,
                                                          options: HKQueryOptions())

    let sampleType = HKSampleType.quantityType(forIdentifier: typeIndentifier)!
    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)

    let heightQuery = HKSampleQuery(sampleType: sampleType,
                                    predicate: lastHeightPredicate,
                                    limit: limit,
                                    sortDescriptors: [sortDescriptor]) {
                                      sampleQuery, results, error in

                                      if let queryError = error {
                                        operation([HKSample](), queryError)
                                        return
                                      }
                                      if let r = results {
                                        operation(r, nil)
                                      }
    }
    
    self.store.execute(heightQuery)
  }
}
