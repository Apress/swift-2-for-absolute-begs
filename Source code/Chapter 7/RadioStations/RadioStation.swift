//
//  RadioStation.swift
//  RadioStations
//
//  Created by Thorn on 7/6/15.
//  Copyright © 2015 Innovativeware. All rights reserved.
//

import UIKit

class RadioStation {
    
    var name: String
    var frequency: Double
    
    init() {
        name="Default"
        frequency=100
    }
    
    class func minAMFrequency() -> Double {
        return 520.0
    }
    
    class func maxAMFrequency() -> Double {
        return 1610.0
    }
    
    class func minFMFrequency() -> Double {
        return 88.3
    }
    
    class func maxFMFrequency() -> Double {
        return 107.9
    }
    
    func band() ->Int {
        if frequency >= RadioStation.minFMFrequency() && frequency <= RadioStation.maxFMFrequency() {
            return 1 //FM
        } else {
            return 0 //AM
        }
    }
    
}

