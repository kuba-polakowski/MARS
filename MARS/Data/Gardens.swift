//
//  Gardens.swift
//  MARS
//
//  Created by Mac on 2/26/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

fileprivate let colors = [#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]

let gardens: [Garden] = [Garden(name: "Temperate Garden", colors: [colors[0].cgColor, colors[1].cgColor]),
                         Garden(name: "Drought Garden", colors: [colors[2].cgColor, colors[3].cgColor]),
                         Garden(name: "Cloud Forest", colors: [colors[4].cgColor, colors[5].cgColor]),
                         Garden(name: "Tundra", colors: [colors[6].cgColor, colors[7].cgColor])
]
