//
//  StationFilter.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import Foundation
import XMLMapper

class StationFilterObject: XMLMappable {
    
    var nodeName: String!
    
    var stationFilter: [StationFilter]
    
    required init?(map: XMLMap) {
        self.stationFilter = []
    }
    
    func mapping(map: XMLMap) {
        self.stationFilter <- map["objStationFilter"]
    }
}

class StationFilter: XMLMappable {
    
    var nodeName: String!
    
    var stationDescriptionSp: String?
    var stationDescription: String?
    var stationCode: String?
    
    required init?(map: XMLMap) {
        
    }
    
    func mapping(map: XMLMap) {
        self.stationDescriptionSp <- map["StationDesc_sp"]
        self.stationDescription <- map["StationDesc"]
        self.stationCode <- map["StationCode"]
    }
}
