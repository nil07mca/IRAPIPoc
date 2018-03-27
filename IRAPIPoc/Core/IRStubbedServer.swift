//
//  IRStubbedServer.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit
/**
 This class is for has API to load stubbed data from bundle
 */
class IRStubbedServer: NSObject {
    func loadStubbedData(forFunction: String!) -> Data! {
        var data = Data()
        var fileName:String?
        if let function = forFunction {
            switch function {
            case Constants.Functions.getAllStations:
                fileName = "getAllStationsXML"
            case Constants.Functions.getAllTrains:
                fileName = "getStationDataByNameXML"
            case Constants.Functions.getAllStops:
                fileName = "getTrainMovementsXML"
            default:
                print("Stubbed data not available")
            }
        }
        
        let filePath = Bundle.main.url(forResource: fileName, withExtension: "xml")
        do {
            data = try Data(contentsOf: filePath!)
        } catch {
            print("Unable to load data: \(error)")
        }
        return data
    }
}
