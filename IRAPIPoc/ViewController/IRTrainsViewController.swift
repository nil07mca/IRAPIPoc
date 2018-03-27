//
//  IRTrainsViewController.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit

/// Hardcoded struct for Morning Journey
private struct MorningJourney {
    static let STATION_NAME = "Rathdrum"
    static let STATION_CODE = "RDRUM"
}

/// Hardcoded struct for Evening Journey
private struct EveningJourney {
    static let STATION_NAME = "Dalkey"
    static let STATION_CODE = "DLKEY"
}

/// Custom cell
class IRTrainCell: UITableViewCell {
    
    @IBOutlet weak var lblDueTime: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblDirection: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class IRTrainsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    private var curentStationCode: String?
    private var curentStationName: String?
    var station: IRStation?
    @IBOutlet weak var journeySwitch: UISegmentedControl!
    private var trains = [IRTrain]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trains from Hello"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (self.station != nil) {
            self.curentStationCode = self.station?.stationCode
            self.title = "Trains from \((self.station?.stationDescription)!)"
            self.journeySwitch.isHidden = true
        } else {
            if IRHelper.isMorning() {
                self.title = "Trains from \(MorningJourney.STATION_NAME)"
                journeySwitch.selectedSegmentIndex = 0
                self.curentStationCode = MorningJourney.STATION_CODE
                
            } else {
                self.title = "Trains from \(EveningJourney.STATION_NAME)"
                journeySwitch.selectedSegmentIndex = 1
                self.curentStationCode = EveningJourney.STATION_CODE
            }
        }
        self.loadTrains()
    }
    
    func loadTrains() {
        SwiftSpinner.show("Loading")
        IRDataManager().getTrainList(stationCode: self.curentStationCode!) { (trains, errorMessage) in
            self.trains = trains as! [IRTrain]
            self.tableView.reloadData()
            SwiftSpinner.hide()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.trains.count == 0 {
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
        return self.trains.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! IRTrainCell
        let train = trains[indexPath.row]
        // Configure the cell...
        cell.lblDestination.text = train.trainDestination
        cell.lblDirection.text = train.trainDirection
        cell.lblDueTime.text = "\(train.trainDueIn) min"
        cell.lblType.text = train.trainType
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
        let train = trains[indexPath.row]
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IRStopsViewController") as? IRStopsViewController {
            if let navigator = navigationController {
                viewController.train = train
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    

    @IBAction func refreshData(_ sender: UIBarButtonItem) {
        self.loadTrains()
    }
    @IBAction func changeJourney(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.title = "Trains from \(MorningJourney.STATION_NAME)"
            self.curentStationCode = MorningJourney.STATION_CODE
            self.loadTrains()
        case 1:
            self.title = "Trains from \(EveningJourney.STATION_NAME)"
            self.curentStationCode = EveningJourney.STATION_CODE
            self.loadTrains()
        default:
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IRStationsViewController") as? IRStationsViewController {
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
    }
}

