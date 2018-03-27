//
//  IRTrain.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit

/**
 This class is for crating objects to hold train data from the service
 http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByCodeXML?StationCode=mhide
 */
class IRTrain: NSObject {
    /// Train code data type as String
    let trainCode: String?
    
    /// Train type data type as String
    let trainType: String?
    
    /// Train destination data type as String
    let trainDestination: String?
    
    /// Train origin data type as String
    let trainOrigin: String?
    
    /// Train due time data type as Int
    let trainDueIn: Int
    
    /// Train late time data type as String
    let trainLate: String?
    
    /// Train direction data type as String
    let trainDirection: String?
    
    //Mark: - Initialisation
    init(trainCode: String, trainType: String, trainOrigin: String, trainDestination: String, trainDueIn: String, trainLate: String, trainDirection: String) {
        self.trainCode = trainCode
        self.trainType = trainType
        self.trainDestination = trainDestination
        self.trainOrigin = trainOrigin
        self.trainDueIn = Int(trainDueIn)!
        self.trainLate = trainLate
        self.trainDirection = trainDirection
    }
}
