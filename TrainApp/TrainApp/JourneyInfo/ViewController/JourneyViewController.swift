//
//  JourneyViewController.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import Foundation
import UIKit
import MapKit
import XMLMapper

class JourneyViewController: UIViewController {
    
    @IBOutlet weak var journey: UILabel!
    @IBOutlet weak var arrival: UILabel!
    @IBOutlet weak var departure: UILabel!
    @IBOutlet weak var dueIn: UILabel!
    @IBOutlet weak var timeOfJourney: UILabel!
    @IBOutlet weak var lastLocation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    var tableViewDataSource: TableViewDataSource<TrainMovement>?
    
    var trainMovement: [TrainMovement]?
    var stationData: StationData?
    var stations: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeDepartedStations(completion: nil)
        self.setJourneyInfo()
        if let trainMovement = trainMovement {
            self.tableViewDataSource = TableViewDataSource.configureData(trainMovement: trainMovement, reuseIdentifier: "movementCell")
            self.tableView.dataSource = self.tableViewDataSource
        }
        refreshControl.addTarget(self, action: #selector(self.refreshTrainMovement), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func refreshTrainMovement() {
        self.removeDepartedStations {
            self.tableView.beginUpdates()
            self.trainMovement?.removeFirst()
            self.tableViewDataSource?.models.removeFirst()
            self.tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            self.tableView.endUpdates()
        }
        refreshControl.endRefreshing()
    }
    
    func setJourneyInfo() {
        guard let stations = stations, let arrival = stationData?.scheduledArrival, let departure = stationData?.scheduledDeparture, let dueIn = stationData?.dueMinutes, let startPointTime = self.getArrivalTime(for: stations[0]), let endPointTime = self.getArrivalTime(for: stations[1]) else {
            return
        }
        self.journey.text = "\(stations[0]) to \(stations[1])"
        self.arrival.text = "Arrival \(arrival)"
        self.departure.text = "Departure \(departure)"
        self.dueIn.text = "Due in \(dueIn) min"
        
        
        if let destinationTime = PlanHelper.getTime(time: endPointTime, format: "HH:mm:ss"), let arrivalTime = PlanHelper.getTime(time: startPointTime, format: "HH:mm:ss") {
            let difference = Date.difference(lhs: arrivalTime, rhs: destinationTime)
            self.timeOfJourney.text = "Duration of travel \(difference.hour!):\(difference.minute!)"
        }
        else {
            self.timeOfJourney.text = "-"
        }
        if let lastLocation = stationData?.lastLocation {
            self.lastLocation.text = lastLocation
        }
        else {
            self.lastLocation.text = "No update"
        }
    }
    
    func getArrivalTime(for station: String) -> String? {
        guard let trainMovement = trainMovement , let stations = stations, stations.count == 2 else {
            return nil
        }
        var time = String()
        trainMovement.forEach {
            if $0.locationFullName == station {
                time = $0.scheduledArrival!
            }
        }
        return time
    }
    
    func removeDepartedStations(completion: (() -> Void)?) {
        guard let trainMovement = trainMovement else {
            return
        }
        self.trainMovement = trainMovement.filter {
            if let departure = $0.scheduledDeparture, let departureTime = PlanHelper.getTime(time: departure, format: "HH:mm:ss"), let currentTime = PlanHelper.getTime(time: PlanHelper.getCurrentDateFormatted(format: "HH:mm:ss"), format: "HH:mm:ss") {
                let difference = Date.difference(lhs: currentTime, rhs: departureTime)
                print(departureTime, currentTime)
                if (difference.hour! >= 0 && difference.minute! >= 0) || departure == "00:00:00" {
                    return true
                }
                else {
                    if let completion = completion {
                        completion()
                    }
                    return false
                }
            }
            return true
        }
    }
}
