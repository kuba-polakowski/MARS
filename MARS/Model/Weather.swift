//
//  Weather.swift
//  MARS
//
//  Created by Mac on 2/25/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import Foundation

enum Precipitation {
    case rain, drizzle, snow, none
}

enum CloudCover {
    case full, partial, none
}

enum TemperatureScale {
    case celsius, farenheit
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
    
    func weatherDescription() -> String {
        var descriptionString = ""
        switch cloudCover {
        case .full:
            descriptionString.append("Cloudy")
        case .partial:
            descriptionString.append("A few clouds")
        case .none:
            descriptionString.append("Clear skies")
        }
        switch precipitation {
        case .rain:
            descriptionString.append(" with heavy rain")
        case .drizzle:
            descriptionString.append(" with light drizzle")
        case .snow:
            descriptionString.append(" with snowfall")
        case .none:
            descriptionString.append("")
        }
        if windSpeed >= 30 {
            descriptionString.append(" and strong wind.")
        } else if windSpeed > 10 {
            descriptionString.append(", windy.")
        } else if windSpeed > 5 {
            descriptionString.append(", slow wind.")
        } else {
            descriptionString.append(", no wind.")
        }


        return descriptionString
    }
}
