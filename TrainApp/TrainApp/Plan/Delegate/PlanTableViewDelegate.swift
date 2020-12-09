//
//  PlanTableViewDelegate.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import Foundation
import UIKit

class PlanTableViewDelegate: NSObject, UITableViewDelegate {
    
    weak var delegate: PlanViewControllerDelegate?
    
    init(delegate: PlanViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelect(row: indexPath.row)
    }
}
