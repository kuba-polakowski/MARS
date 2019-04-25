//
//  Garden.swift
//  MARS
//
//  Created by Mac on 2/26/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

struct Garden {
    let name: GardenName
    let colors: [CGColor]
}

enum GardenName: String {
    case temperate, drought, tropical, snowy
}
