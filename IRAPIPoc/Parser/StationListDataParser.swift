//
//  StationListDataParser.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit
/**
 This class is for parsing station data from the service and return an array
 http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML_WithStationType?StationType=D
 */
class StationListDataParser: NSObject, XMLParserDelegate {
    private var parser = XMLParser()
    private var stations = [IRStation]()
    private var stationDescription:String?
    private var stationCode:String?
    private var stationId:String?
    private var element:String?
    func parseData(data: Data!) -> [IRStation] {
        parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return stations
    }
    
    // Mark: Parser methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.element = elementName
        if elementName == XMLKeys.kStation {
            stationDescription = ""
            stationCode = ""
            stationId = ""
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == XMLKeys.kStation {
            let station = IRStation(stationDescription: self.stationDescription!, stationCode: self.stationCode!, stationId: self.stationId!)
            self.stations.append(station)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimedSring = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if self.element == XMLKeys.kStationDescription {
            self.stationDescription?.append(trimedSring)
        }else if self.element == XMLKeys.kStationCode {
            self.stationCode?.append(trimedSring)
        }else if self.element == XMLKeys.kStationId {
            self.stationId?.append(trimedSring)
        }
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
    }

}
