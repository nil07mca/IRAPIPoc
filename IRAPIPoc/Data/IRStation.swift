//
//  IRStation.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit
/**
 This class is for crating objects to hold station data from the service
 http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML_WithStationType?StationType=D
*/
class IRStation: NSObject {
    /// Station description data type as String
    let stationDescription: String?
    
    /// Station code data type as String
    let stationCode: String?
    
    /// Station Id data type as String
    let stationId: String?
    
    //Mark: - Initialisation
    init(stationDescription: String, stationCode: String, stationId:String) {
        self.stationDescription = stationDescription
        self.stationCode = stationCode
        self.stationId = stationId
    }
}
