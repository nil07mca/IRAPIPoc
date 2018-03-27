//
//  IRStopsViewController.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit

class IRStopCell: UITableViewCell {
    
    @IBOutlet weak var lblStopName: UILabel!
    @IBOutlet weak var lblArrivalTime: UILabel!
    @IBOutlet weak var lblStopNumber: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
class IRStopsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var stopTableView: UITableView!
    var train: IRTrain?
    var stops = [IRStops]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backItem?.title = "Back"
        self.title = "\((train?.trainOrigin)!) to \((train?.trainDestination)!) Train Stops"
        
        let trainId = train?.trainCode
        SwiftSpinner.show("Loading")
        IRDataManager().getStopList(trainCode: trainId!) { (stops, errorMessage) in
            self.stops = stops as! [IRStops]
            self.stopTableView.reloadData()
            SwiftSpinner.hide()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.stops.count == 0 {
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
        return self.stops.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! IRStopCell
        
        // Configure the cell...
        let stop = self.stops[indexPath.row]
        cell.lblStopName.text = stop.stopName
        cell.lblStopNumber.text = String("#\(stop.stopNumber)")
        cell.lblArrivalTime.text = stop.stopArrivalTime
        
        if (indexPath.row % 2 == 0)
        {
            cell.backgroundColor = #colorLiteral(red: 0.9458829761, green: 0.9584777951, blue: 0.8345526457, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.899579823, green: 0.9326078296, blue: 0.9724051356, alpha: 1)
        }
        return cell
    }
}
