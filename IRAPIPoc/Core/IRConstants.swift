//
//  IRConstants.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit

// Base URL and functions
struct Constants {
    static let BASE_URL = "http://api.irishrail.ie/realtime/realtime.asmx/"
    struct Functions {
        static let getAllStations = "getAllStationsXML_WithStationType?"
        static let getAllTrains = "getStationDataByCodeXML?"
        static let getAllStops = "getTrainMovementsXML?"
    }
    
    
}

// Station type
enum StationType : Int{
    case all = 0
    case mainline
    case suburban
    case dart
}

// All xml element keys
struct XMLKeys {
    
    static let kStation = "objStation"
    static let kStationDescription = "StationDesc"
    static let kStationCode = "StationCode"
    static let kStationId = "StationId"
    
    static let kStationData = "objStationData"
    static let kTraincode = "Traincode"
    static let kTraintype = "Traintype"
    static let kTrainOrigin = "Origin"
    static let kTrainDestination = "Destination"
    static let kTrainDuein = "Duein"
    static let kTrainLate = "Late"
    static let kTrainDirection = "Direction"
    
    
    static let kTrainMovements = "objTrainMovements"
    static let kLocationOrder =  "LocationOrder"
    static let kLocationFullName = "LocationFullName"
    static let kScheduledArrival = "ScheduledArrival"
    static let kExpectedArrival = "ExpectedArrival"
    
}

