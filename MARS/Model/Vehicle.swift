//
//  Vehicle.swift
//  MARS
//
//  Created by Mac on 2/25/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import MapKit

struct Vehicle {
    let name: String
    var charge: Int
    var location: CLLocationCoordinate2D
    
    init(name: String, charge: Int, location: CLLocationCoordinate2D) {
        self.name = name
        self.charge = charge
        self.location = location
    }
}
