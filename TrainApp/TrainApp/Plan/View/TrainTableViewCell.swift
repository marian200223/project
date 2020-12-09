//
//  TrainTableViewCell.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import UIKit

class TrainTableViewCell: UITableViewCell {

    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var scheduled: UILabel!
    @IBOutlet weak var dueIn: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(station: StationData) {
        if let origin = station.origin, let dueMinutes = station.dueMinutes, let trainCode = station.trainCode {
            self.origin.text = "\(origin) (\(trainCode))"
            self.dueIn.text = "\(dueMinutes) min"
        }
        self.destination.text = station.destination
        self.scheduled.text = station.scheduledDeparture
        if station.lastLocation == nil {
            self.status.text = "No Information"
        }
        else {
            self.status.text = station.lastLocation
        }
    }
}
