//
//  IRStops.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit
/**
 This class is for crating objects to hold stops data from the service
 http://api.irishrail.ie/realtime/realtime.asmx/getTrainMovementsXML?TrainId=e109&TrainDate=21 dec 2011
 */
class IRStops: NSObject {
    /// Stop name as string
    let stopName: String?
    
    /// Stop number as Int
    let stopNumber: Int
    
    /// Scheduled arrival time as string
    let stopArrivalTime: String?
    
    /// Expected arrival time  as string
    let stopExpectedArrivalTime: String?
    
    //Mark: - Initialisation
    init(stopName: String, stopNumber: String, stopArrivalTime: String, stopExpectedArrivalTime: String) {
        self.stopName = stopName;
        self.stopArrivalTime = stopArrivalTime
        self.stopNumber = Int(stopNumber)!
        self.stopExpectedArrivalTime = stopExpectedArrivalTime
    }
}
