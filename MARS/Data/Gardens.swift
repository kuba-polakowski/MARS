//
//  Gardens.swift
//  MARS
//
//  Created by Mac on 2/26/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit


struct Gardens {
    static let all: [Garden] = [Garden(name: .temperate, colors: [#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.2955036645, green: 0.7190713693, blue: 0.0885253056, alpha: 1).cgColor]),
                             Garden(name: .drought, colors: [#colorLiteral(red: 0.3162902609, green: 0.8090613793, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6107717714, blue: 0.1618424948, alpha: 1).cgColor]),
                             Garden(name: .tropical, colors: [#colorLiteral(red: 0.6275568803, green: 0.9793455005, blue: 0, alpha: 1).cgColor, #colorLiteral(red: 0.008528554732, green: 0.6285091224, blue: 0, alpha: 1).cgColor]),
                             Garden(name: .snowy, colors: [#colorLiteral(red: 0.08818300169, green: 0.6681552921, blue: 0.9764705896, alpha: 1).cgColor, #colorLiteral(red: 0.7665391265, green: 1, blue: 0.9699948018, alpha: 1).cgColor])
    ]
}
