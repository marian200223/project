//
//  PlanDataAccessObject.swift
//  TrainApp
//
//  Created by Marian Iconaru on 8/12/20.
//

import Foundation
import PromiseKit
import XMLMapper

class PlanDataAccessObject {
    
    weak var delegate: DataAccessObjectDelegate?
    private var stationData: [StationData]
    private var trainMovementObject: [TrainMovementObject]
    
    init(delegate: DataAccessObjectDelegate) {
        self.delegate = delegate
        self.stationData = [StationData]()
        self.trainMovementObject = [TrainMovementObject]()
    }
    
    func getTrainInfo(trainId: String, trainDate: String) -> Promise<Data> {
        return HTTPClient.sharedInstance.get(route: HTTPRouter.Routes.getTrainInfo, parameters: ["TrainId": trainId, "TrainDate": trainDate.urlFormatted() ?? ""])
    }
    
    func getArrivingTrains(startPoint: String, endPoint: String) -> Promise<[StationData]> {
        return HTTPClient.sharedInstance.get(route: HTTPRouter.Routes.getTrainsByStationName, parameters: ["StationDesc": startPoint.urlFormatted()!]).map { data -> [StationData] in
            //1:- get trains that arrive in startPoint station
            let xmlDictionary = try XMLSerialization.xmlObject(with: data) as? [String: Any]
            let stationDataObject = XMLMapper<StationDataObject>().map(XMLObject: xmlDictionary)
            self.stationData = stationDataObject!.stationData
            return stationDataObject!.stationData
        }
    }
    
    func getTrainMovement(startPoint: String, endPoint: String) -> Promise<[Data]> {
        return self.getArrivingTrains(startPoint: startPoint, endPoint: endPoint).thenMap { (object: StationData) in
            //2:- get train movement info for train codes that arrive in startPoint (from no. 1)
            return self.getTrainInfo(trainId: object.trainCode!, trainDate: PlanHelper.getCurrentDateFormatted(format: "dd MMM yy"))
        }
    }
    
    func filterTrainMovement(startPoint: String, endPoint: String) -> Promise<[TrainMovementObject]> {
        return self.getTrainMovement(startPoint: startPoint, endPoint: endPoint).map { data -> [TrainMovementObject] in
            //3:- filter train movement remaining only revelant information; movement from startPoint to endPoint eg. Arklow -> Shankill
            var trainMovements = [TrainMovementObject]()
            try data.forEach {
                let xmlDictionary = try XMLSerialization.xmlObject(with: $0) as? [String: Any]
                let trainMovementObject = XMLMapper<TrainMovementObject>().map(XMLObject: xmlDictionary)
                if PlanHelper.checkRoute(trainMovement: trainMovementObject!.trainMovement, startPoint: startPoint, endPoint: endPoint) {
                    trainMovements.append(trainMovementObject!)
                }
            }
            return trainMovements
        }
    }
    
    func getTrainsForRoute(startPoint: String, endPoint: String) {
        self.filterTrainMovement(startPoint: startPoint, endPoint: endPoint).done { data in
            //4:- filter trains that satisfy startPoint and endPoint (data from request no. 5 to fulfill specific cell information)
            var stations = [StationData]()
            var movement = [TrainMovementObject]()
            data.forEach {
                let movementObject = PlanHelper.checkTrains(trainMovementObject: $0, stationData: self.stationData)
                stations.append(movementObject.0!)
                movement.append(movementObject.1!)
            }
            self.trainMovementObject = movement
            self.stationData = stations
            self.delegate?.willReceiveData(stationData: stations)
        }
        .catch {
            print($0.localizedDescription)
        }
        .finally {
            self.delegate?.didReceiveData()
        }
    }
    
    func getTrainMovementObject() -> [TrainMovementObject] {
        return self.trainMovementObject
    }
    func getStationData() -> [StationData] {
        return self.stationData
    }
}
