//
//  TrainPosition.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import Foundation
import XMLMapper

class TrainObject: XMLMappable {
    var nodeName: String!
    
    var trainPositions: [TrainPosition]
    
    required init?(map: XMLMap) {
        self.trainPositions = []
    }
    
    func mapping(map: XMLMap) {
        self.trainPositions <- map["objTrainPositions"]
    }
}

class TrainPosition: XMLMappable {
    
    var nodeName: String!
    
    var trainStatus: String?
    var trainLatitude: Double?
    var trainLongitude: Double?
    var trainCode: String?
    var trainDate: String?
    var publicMessage: String?
    var direction: String?
    
    required init?(map: XMLMap) {
        
    }
    
    func mapping(map: XMLMap) {
        self.trainStatus <- map["TrainStatus"]
        self.trainLatitude <- map["TrainLatitude"]
        self.trainLongitude <- map["TrainLongitude"]
        self.trainCode <- map["TrainCode"]
        self.trainDate <- map["TrainDate"]
        self.publicMessage <- map["PublicMessage"]
        self.direction <- map["Direction"]
    }
}
