//
//  TrainMovement.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import Foundation
import XMLMapper

class TrainMovementObject: XMLMappable {
    
    var nodeName: String!
    
    var trainMovement: [TrainMovement]
    
    required init?(map: XMLMap) {
        self.trainMovement = []
    }
    
    func mapping(map: XMLMap) {
        self.trainMovement <- map["objTrainMovements"]
    }
}

class TrainMovement: XMLMappable {
    
    var nodeName: String!
    
    var trainCode: String?
    var trainDate: String?
    var locationCode: String?
    var locationFullName: String?
    var locationOrder: Int?
    var locationType: String?
    var trainOrigin: String?
    var trainDestination: String?
    var scheduledArrival: String?
    var scheduledDeparture: String?
    var expectedArrival: String?
    var expectedDeparture: String?
    var arrival: String?
    var departure: String?
    var autoArrival: Int?
    var autoDeparture: Int?
    var stopType: String?
    
    required init?(map: XMLMap) {
        
    }
    
    func mapping(map: XMLMap) {
        self.trainCode <- map["TrainCode"]
        self.trainDate <- map["TrainDate"]
        self.locationCode <- map["LocationCode"]
        self.locationFullName <- map["LocationFullName"]
        self.locationOrder <- map["LocationOrder"]
        self.locationType <- map["LocationType"]
        self.trainOrigin <- map["TrainOrigin"]
        self.trainDestination <- map["TrainDestination"]
        self.scheduledArrival <- map["ScheduledArrival"]
        self.scheduledDeparture <- map["ScheduledDeparture"]
        self.expectedArrival <- map["ExpectedArrival"]
        self.expectedDeparture <- map["ExpectedDeparture"]
        self.arrival <- map["Arrival"]
        self.departure <- map["Departure"]
        self.autoArrival <- map["AutoArrival"]
        self.autoDeparture <- map["AutoDepart"]
        self.stopType <- map["StopType"]
    }
}
