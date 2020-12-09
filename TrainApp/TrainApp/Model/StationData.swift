//
//  StationData.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import Foundation
import XMLMapper

class StationDataObject: XMLMappable {
    var nodeName: String!
    
    var stationData: [StationData]
    
    required init?(map: XMLMap) {
        self.stationData = []
    }
    
    func mapping(map: XMLMap) {
        self.stationData <- map["objStationData"]
    }
}

class StationData: XMLMappable {
    
    var nodeName: String!
    
    var serverTime: String?
    var trainCode: String?
    var stationFullName: String?
    var stationCode: String?
    var queryTime: Date?
    var trainDate: String?
    var origin: String?
    var destination: String?
    var originTime: String?
    var destinationTime: String?
    var status: String?
    var lastLocation: String?
    var dueMinutes: Int?
    var lateMinutes: Int?
    var expectedArrival: String?
    var expectedDeparture: String?
    var scheduledArrival: String?
    var scheduledDeparture: String?
    var direction: String?
    var trainType: String?
    var locationType: String?
    
    required init?(map: XMLMap) {
        
    }
    
    func mapping(map: XMLMap) {
        self.serverTime <- map["Servertime"]
        self.trainCode <- map["Traincode"]
        self.stationFullName <- map["StationfullName"]
        self.stationCode <- map["Stationcode"]
        self.queryTime <- map["Querytime"]
        self.trainDate <- map["Traindate"]
        self.origin <- map["Origin"]
        self.destination <- map["Destination"]
        self.originTime <- map["Origintime"]
        self.destinationTime <- map["Destinationtime"]
        self.status <- map["Status"]
        self.lastLocation <- map["Lastlocation"]
        self.dueMinutes <- map["Duein"]
        self.lateMinutes <- map["Late"]
        self.expectedArrival <- map["Exparrival"]
        self.expectedDeparture <- map["Expdepart"]
        self.scheduledArrival <- map["Scharrival"]
        self.scheduledDeparture <- map["Schdepart"]
        self.direction <- map["Direction"]
        self.trainType <- map["Traintype"]
        self.locationType <- map["Locationtype"]
    }
}
