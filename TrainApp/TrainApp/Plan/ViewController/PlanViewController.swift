//
//  ViewController.swift
//  TrainApp
//
//  Created by Marian Iconaru on 7/12/20.
//

import UIKit
import XMLMapper
import PromiseKit



class PlanViewController: UIViewController {
    
    @IBOutlet weak var startPoint: UITextField!
    @IBOutlet weak var endPoint: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var tableViewDataSource: TableViewDataSource<StationData>?
    var tableViewDelegate: PlanTableViewDelegate?
    var stationData = [StationData]()
    var trainMovement = [TrainMovementObject]()
    var dataAccessObject: PlanDataAccessObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataAccessObject = PlanDataAccessObject(delegate: self)
        self.tableViewDataSource = TableViewDataSource.configureData(stationData: stationData, reuseIdentifier: "trainCell")
        self.tableViewDelegate = PlanTableViewDelegate(delegate: self)
        self.setDelegates()
        self.setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshControl.addTarget(self, action: #selector(self.refreshArrivals), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func refreshArrivals() {
        if let startPoint = self.startPoint.text, let endPoint = self.endPoint.text {
            self.dataAccessObject?.getTrainsForRoute(startPoint: startPoint.formatted(), endPoint: endPoint.formatted())
        }
        else {
            self.dataAccessObject?.getTrainsForRoute(startPoint: "Arklow", endPoint: "Shankill")
        }
        refreshControl.endRefreshing()
    }
    
    func setDelegates() {
        self.tableView.delegate = self.tableViewDelegate
        self.startPoint.delegate = self
        self.endPoint.delegate = self
    }
    
    func setUpLayout() {
        self.startPoint.setUpBorderLayout()
        self.endPoint.setUpBorderLayout()
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 169/255, green: 212/255, blue: 94/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTrainInfo" {
            if let nextVC = segue.destination as? JourneyViewController {
                guard let row = sender as? Int else {
                    return
                }
                nextVC.trainMovement = self.dataAccessObject?.getTrainMovementObject()[row].trainMovement
                nextVC.stationData = self.stationData[row]
                if let startPoint = self.startPoint.text, let endPoint = self.endPoint.text {
                    nextVC.stations = [startPoint.firstLetterUppercase(), endPoint.firstLetterUppercase()]
                }
            }
        }
    }
    
    func checkAvailability() {
        if self.stationData.count == 0 {
            let alert = Alert.showAlert(message: "Please try again later! There are currently no trains for your trip.")
            self.navigationController?.present(alert, animated: true)
        }
    }
}

extension PlanViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextTextField = textField.superview?.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        } else {
            if let startPoint = self.startPoint.text, startPoint.isEmpty {
                self.startPoint.isComplete(filled: false)
            }
            else {
                textField.resignFirstResponder()
                Spinner.shared.showActivityIndicator(view: self.view)
                self.dataAccessObject?.getTrainsForRoute(startPoint: self.startPoint.text?.firstLetterUppercase() ?? "Arklow", endPoint: self.endPoint.text?.firstLetterUppercase() ?? "Shankill")
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && string == "" {
            textField.isComplete(filled: false)
        } else {
            textField.isComplete(filled: true)
            
        }
        return true
    }
}

extension PlanViewController: PlanViewControllerDelegate {
    
    func didSelect(row: Int) {
        self.performSegue(withIdentifier: "showTrainInfo", sender: row)
    }
    
}

extension PlanViewController: DataAccessObjectDelegate {
    func willReceiveData(stationData: [StationData]) {
        self.stationData = stationData
        self.checkAvailability()
        self.tableViewDataSource = TableViewDataSource.configureData(stationData: stationData, reuseIdentifier: "trainCell")
        self.tableView.dataSource = self.tableViewDataSource
    }
    func didReceiveData() {
        self.tableView.reloadData()
        Spinner.shared.hideActivityIndicator(completion: nil)
    }
}

protocol PlanViewControllerDelegate: class {
    func didSelect(row: Int)
}

protocol DataAccessObjectDelegate: class {
    func willReceiveData(stationData: [StationData])
    func didReceiveData()
}
