//
//  TrainListDataParser.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit
/**
 This class is for parsing station data from the service and return an array
 http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByCodeXML?StationCode=mhide
 */
class TrainListDataParser: NSObject, XMLParserDelegate {
    private var parser = XMLParser()
    private var trains = [IRTrain]()
    private var element:String?
    
    private var trainCode: String?
    private var trainType: String?
    private var trainDestination: String?
    private var trainOrigin: String?
    private var trainDueIn: String?
    private var trainLate: String?
    private var trainDirection: String?
    
    func parseData(data: Data!) -> [IRTrain] {
        parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return trains.sorted(by: { $0.trainDueIn < $1.trainDueIn })
    }
    
    // Mark: Parser methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        self.element = elementName
        if elementName == XMLKeys.kStationData {
            trainCode = ""
            trainType = ""
            trainDestination = ""
            trainOrigin = ""
            trainDueIn = ""
            trainLate = ""
            trainDirection = ""
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == XMLKeys.kStationData {
            let train = IRTrain(trainCode: trainCode!, trainType: trainType!, trainOrigin: trainOrigin!, trainDestination: trainDestination!, trainDueIn: trainDueIn!, trainLate: trainLate!, trainDirection: trainDirection!)
            self.trains.append(train)
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimedSring = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if self.element == XMLKeys.kTraincode {
            self.trainCode?.append(trimedSring)
        }else if self.element == XMLKeys.kTraintype {
            self.trainType?.append(trimedSring)
        }else if self.element == XMLKeys.kTrainDestination {
            self.trainDestination?.append(trimedSring)
        }else if self.element == XMLKeys.kTrainDuein {
            self.trainDueIn?.append(trimedSring)
        }else if self.element == XMLKeys.kTrainLate{
            self.trainLate?.append(trimedSring)
        }else if self.element == XMLKeys.kTrainDirection {
            self.trainDirection?.append(trimedSring)
        }else if self.element == XMLKeys.kTrainOrigin {
            self.trainOrigin?.append(trimedSring)
        }
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
    }
}
