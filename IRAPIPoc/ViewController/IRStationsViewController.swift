//
//  IRStationsViewController.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit

/// Custom cell
class IRStationCell: UITableViewCell {
    
    @IBOutlet weak var lblStationName: UILabel!
    @IBOutlet weak var lblStationCode: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
class IRStationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var stations = [IRStation]()
    
    @IBOutlet weak var stationsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Availabe Stations In Network"
        self.loadStations(type: .all)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadStations(type: StationType) {
        SwiftSpinner.show("Loading")
        IRDataManager().getStationList(ofType: type) { (stations, errorMessage) in
            self.stations = stations as! [IRStation]
            self.stationsTable.reloadData()
            SwiftSpinner.hide()
            
        }
    }
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.stations.count == 0 {
            return "No data, please try again later"
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.stations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! IRStationCell
        
        let station = stations[indexPath.row]
        cell.lblStationName.text = station.stationDescription
        cell.lblStationCode.text = station.stationCode
        cell.accessoryType = .disclosureIndicator
        if (indexPath.row % 2 == 0)
        {
            cell.backgroundColor = #colorLiteral(red: 0.9458829761, green: 0.9584777951, blue: 0.8345526457, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.899579823, green: 0.9326078296, blue: 0.9724051356, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stations[indexPath.row]
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IRTrainsViewController") as? IRTrainsViewController {
            if let navigator = navigationController {
                viewController.station = station
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    @IBAction func changeStationType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.loadStations(type: .all)
        case 1:
            self.loadStations(type: .mainline)
        case 2:
            self.loadStations(type: .suburban)
        case 3:
            self.loadStations(type: .dart)
        default:
            self.loadStations(type: .all)
        }
    }
}
