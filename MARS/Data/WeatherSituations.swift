//
//  WeatherSituations.swift
//  MARS
//
//  Created by Mac on 2/25/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import Foundation

struct WeatherSituations {
    static let current: [Weather] = [Weather(gardenName: .temperate, temperature: 15, windSpeed: 10, precipitation: .drizzle, cloudCover: .partial),
                                     Weather(gardenName: .drought, temperature: 31, windSpeed: 15, precipitation: .none, cloudCover: .none),
                                     Weather(gardenName: .tropical, temperature: 23, windSpeed: 30, precipitation: .rain, cloudCover: .partial),
                                     Weather(gardenName: .snowy, temperature: -5, windSpeed: 4, precipitation: .snow, cloudCover: .full),
    ]
}
