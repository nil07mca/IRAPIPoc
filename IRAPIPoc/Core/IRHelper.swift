//
//  IRHelper.swift
//  IRAPIPoc
//
//  Created by Niladri Chatterjee on 18/03/2018.
//  Copyright © 2018 Niladri Chatterjee. All rights reserved.
//

import UIKit
/**
 This class is for global helper methods
 */
class IRHelper: NSObject {
    /// Prevent initialisation
    private override init() {}
    
    class func isMorning() -> Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 0 && hour < 12 {
            return true
        }
        return false
    }
}
