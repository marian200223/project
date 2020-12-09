//
//  MovementTableViewCell.swift
//  TrainApp
//
//  Created by Marian Iconaru on 9/12/20.
//

import UIKit

class MovementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var arrival: UILabel!
    @IBOutlet weak var departure: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(trainMovement: TrainMovement) {
        guard let location = trainMovement.locationFullName, let arrival = trainMovement.scheduledArrival, let departure = trainMovement.scheduledDeparture else {
            return
        }
        self.locationName.text = location
        if arrival != "00:00:00" {
            self.arrival.text = arrival
        }
        else {
            self.arrival.text = ""
        }
        if departure != "00:00:00" {
            self.departure.text = departure
        }
        else {
            self.departure.text = ""
        }
    }

}
