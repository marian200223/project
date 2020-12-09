//
//  Station.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import Foundation
import XMLMapper

class StationObject: XMLMappable {
    
    var nodeName: String!
    
    var stations: [Station]
    
    public init() {
        self.stations = []
    }
    
    required init?(map: XMLMap) {
        self.stations = []
    }
    
    func mapping(map: XMLMap) {
        self.stations <- map["objStation"]
    }
}

class Station: XMLMappable {
    
    var nodeName: String!
    
    var stationId: Int?
    var stationDescription: String?
    var stationAlias: String?
    var stationLatitude: Double?
    var stationLongitude: Double?
    var stationCode: String?
    
    required init?(map: XMLMap) {
        
    }
    
    func mapping(map: XMLMap) {
        self.stationId <- map["StationId"]
        self.stationDescription <- map["StationDesc"]
        self.stationAlias <- map["StationAlias"]
        self.stationLatitude <- map["StationLatitude"]
        self.stationLongitude <- map["StationLongitude"]
        self.stationCode <- map["StationCode"]
    }
    
}
