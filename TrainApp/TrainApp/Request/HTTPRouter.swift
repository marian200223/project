//
//  HTTPRouter.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import Foundation

class HTTPRouter {
    
    static let baseURLString = "http://api.irishrail.ie/realtime/realtime.asmx/"
    
    enum Routes {
        case getAllStationsXML
        case getStationByType
        case getCurrentTrains
        case getTrainByType
        case getTrainsByStationName
        case getTrainsByStationInterval
        case getTrainsByStationCode
        case getTrainsByStationDefinedInterval
        case getStationByName
        case getTrainInfo
        
        public var urlString: String {
            let path: String = {
                switch self {
                //1
                case .getAllStationsXML:
                    return "getAllStationsXML"
                //2
                case .getStationByType:
                    return "getAllStationsXML_WithStationType?"
                //3
                case .getCurrentTrains:
                    return "getCurrentTrainsXML"
                //4
                case .getTrainByType:
                    return "getCurrentTrainsXML_WithTrainType?"
                //5,6
                case .getTrainsByStationName, .getTrainsByStationInterval:
                    return "getStationDataByNameXML?"
                //7
                case .getTrainsByStationCode:
                    return "getStationDataByCodeXML?"
                //8
                case .getTrainsByStationDefinedInterval:
                    return "getStationDataByCodeXML_WithNumMins"
                //9
                case .getStationByName:
                    return "getStationsFilterXML?"
                //10
                case .getTrainInfo:
                    return "getTrainMovementsXML?"
                }
            }()
            return HTTPRouter.baseURLString + path
        }
    }
    
    
}
