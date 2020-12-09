//
//  PlanHelper.swift
//  TrainApp
//
//  Created by Marian Iconaru on 8/12/20.
//

import Foundation
import PromiseKit

class PlanHelper {
    
    static func checkRoute(trainMovement: [TrainMovement], startPoint: String, endPoint: String) -> Bool {
        var startStation = false
        var endStation = false
        
        trainMovement.forEach {
            if $0.locationFullName == startPoint && endStation == false {
                startStation = true
            }
            if $0.locationFullName == endPoint {
                endStation = true
            }
        }
        return startStation && endStation
    }
    static func checkTrains(trainMovementObject: TrainMovementObject, stationData: [StationData]) -> (StationData?, TrainMovementObject?) {
        var stationDataFiltered: StationData?
        var trainMovement: TrainMovementObject?
        stationData.forEach {
            if $0.trainCode == trainMovementObject.trainMovement[0].trainCode {
                stationDataFiltered = $0
                trainMovement = trainMovementObject
            }
        }
        return (stationDataFiltered, trainMovement)
    }
    
    static func getCurrentDateFormatted(format: String) -> String {
        let timeZone = TimeZone(identifier: "Europe/London")
        let dateFormat = DateFormatter()
        dateFormat.timeZone = timeZone
        dateFormat.dateFormat = format
        let date = dateFormat.string(from: Date())
        return date
    }
    
    
    static func getTime(time: String, format: String) -> Date? {
        let timeZone = TimeZone(identifier: "Europe/London")
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        dateFormat.timeZone = timeZone
        let date = dateFormat.date(from: time)
        return date
    }
}
