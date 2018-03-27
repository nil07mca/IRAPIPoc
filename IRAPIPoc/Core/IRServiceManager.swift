//
//  IRServiceManager.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit
/**
 This class is for calling API from gateway. Also this class is responsinle
 to detect LIVE or STUBBED settings and load local data for STUBBED version
 */
class IRServiceManager: NSObject {
    typealias serviceResponse = (Data?, String) -> ()
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    let defaultSession = URLSession(configuration: .default)
    
    //Mark : - Initiate network call or load from stubbed data
    func getServiceResponse(forFunction: String!, queryString: String!, completion: @escaping serviceResponse) {
        #if STUBBED
            print("STUBBED")
            guard let data = IRStubbedServer().loadStubbedData(forFunction: forFunction) else { return }
            completion(data, self.errorMessage)
        #else
            print("LIVE")
            var urlString = Constants.BASE_URL
            if var functionName = forFunction {
                if let queryString = queryString {
                    functionName.append(queryString)
                }
                urlString.append(functionName)
                let escapedAddress = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                dataTask = defaultSession.dataTask(with: URL.init(string: escapedAddress)!, completionHandler: { (data, response, error) in
                    defer { self.dataTask = nil}
                    if let error = error {
                        self.errorMessage.append(error.localizedDescription)
                    } else if let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                        DispatchQueue.main.async {
                            completion(data, self.errorMessage)
                        }
                    }
                    
                })
                dataTask?.resume()
            }
        #endif
    }
}
