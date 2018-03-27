//
//  StationStopsDataParser.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit
/**
 This class is for parsing station data from the service and return an array
 http://api.irishrail.ie/realtime/realtime.asmx/getTrainMovementsXML?TrainId=e109&TrainDate=21 dec 2011
 */
class StationStopsDataParser: NSObject, XMLParserDelegate {
    private var parser = XMLParser()
    private var stops = [IRStops]()
    private var element:String?
    
    private var  stopName: String?
    private var  stopNumber: String?
    private var  stopArrivalTime: String?
    private var  stopExpectedArrivalTime: String?
    
    func parseData(data: Data!) -> [IRStops] {
        parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return stops.sorted(by: { $0.stopNumber < $1.stopNumber })
    }
    
    // Mark: Parser methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.element = elementName
        if elementName == XMLKeys.kTrainMovements {
            stopName = ""
            stopNumber = ""
            stopExpectedArrivalTime = ""
            stopArrivalTime = ""
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == XMLKeys.kTrainMovements {
            let stop = IRStops(stopName: self.stopName!, stopNumber: self.stopNumber!, stopArrivalTime: self.stopArrivalTime!, stopExpectedArrivalTime: self.stopExpectedArrivalTime!)
            self.stops.append(stop)
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimedSring = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if self.element == XMLKeys.kLocationOrder {
            self.stopNumber?.append(trimedSring)
        }else if self.element == XMLKeys.kScheduledArrival {
            self.stopArrivalTime?.append(trimedSring)
        }else if self.element == XMLKeys.kExpectedArrival {
            self.stopExpectedArrivalTime?.append(trimedSring)
        }else if self.element == XMLKeys.kLocationFullName {
            self.stopName?.append(trimedSring)
        }
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
    }
}
