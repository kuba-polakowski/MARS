//
//  Weather.swift
//  MARS
//
//  Created by Mac on 2/25/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import Foundation

enum Precipitation {
    case rain, drizzle, none
}

enum CloudCover {
    case full, partial, none
}

struct Weather {
    let temperature: Int
    let windSpeed: Int
    let precipitation: Precipitation
    let cloudCover: CloudCover
    
    func tempInFarenheit() -> Int {
        return Int(Double(temperature) * 1.8 + 32)
    }
    
    func windSpeedInMph() -> Int {
        return Int(Double(windSpeed) * 0.62)
    }
}
