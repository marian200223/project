//
//  TableViewDataSource.swift
//  TrainApp
//
//  Created by Marian Iconaru on 9/12/20.
//

import Foundation
import UIKit

class TableViewDataSource<Model>: NSObject, UITableViewDataSource {
    
    typealias CellConfigurator = (Model, UITableViewCell) -> Void
    let cellConfigurator: CellConfigurator
    
    var models: [Model]
    let reuseIdentifier: String
    
    init(models: [Model], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.cellConfigurator = cellConfigurator
        self.models = models
        self.reuseIdentifier = reuseIdentifier
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        self.cellConfigurator(model, cell)
        return cell
    }
}

extension TableViewDataSource where Model == StationData {
    
    static func configureData(stationData: [StationData], reuseIdentifier: String) -> TableViewDataSource {
        return TableViewDataSource(models: stationData, reuseIdentifier: reuseIdentifier, cellConfigurator: { (data, cell) in
            if let stationCell = cell as? TrainTableViewCell {
                stationCell.configureCell(station: data)
            }
        })
    }
}

extension TableViewDataSource where Model == TrainMovement {
    static func configureData(trainMovement: [TrainMovement], reuseIdentifier: String) -> TableViewDataSource {
        return TableViewDataSource(models: trainMovement, reuseIdentifier: reuseIdentifier, cellConfigurator: { (data, cell) in
            if let movementCell = cell as? MovementTableViewCell {
                movementCell.configureCell(trainMovement: data)
            }
            
        })
    }
}
