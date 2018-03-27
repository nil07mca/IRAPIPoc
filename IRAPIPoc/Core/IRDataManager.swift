//
//  IRDataManager.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit
/**
 This class is working as a bridge between service manager and parser. Exposed api are there to initiate network calls and pass the data to parser.
 */
class IRDataManager: NSObject {
    typealias serviceResponse = ([Any]?, String) -> ()
    
    /// Exposed API to load station list
    func getStationList(ofType: StationType, completion: @escaping serviceResponse) {
        var stationType:String!
        switch ofType {
        case .all:
            stationType = "A"
        case .mainline:
            stationType = "M"
        case .suburban:
            stationType = "S"
        case .dart:
            stationType = "D"
        }
        let queryString = "StationType=" + stationType
        IRServiceManager().getServiceResponse(forFunction: Constants.Functions.getAllStations, queryString: queryString
            , completion: { (data, errorMessage) in
                let stations = StationListDataParser().parseData(data: data)
                completion(stations, errorMessage)
        })
    }
    
    /// Exposed API to load train list
    func getTrainList(stationCode: String, completion: @escaping serviceResponse) {
        let queryString = "StationCode=" + stationCode
        IRServiceManager().getServiceResponse(forFunction: Constants.Functions.getAllTrains, queryString: queryString
            , completion: { (data, errorMessage) in
                let trains = TrainListDataParser().parseData(data: data)
                completion(trains, errorMessage)
        })
    }
    
    /// Exposed API to load stop list
    func getStopList(trainCode: String, completion: @escaping serviceResponse) {
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let todaysDate = dateFormatter.string(from: date)
        
        let queryString = "TrainId=" + trainCode + "&TrainDate=" + todaysDate
        IRServiceManager().getServiceResponse(forFunction: Constants.Functions.getAllStops, queryString: queryString
            , completion: { (data, errorMessage) in
                let trains = StationStopsDataParser().parseData(data: data)
                completion(trains, errorMessage)
        })
    }
}
