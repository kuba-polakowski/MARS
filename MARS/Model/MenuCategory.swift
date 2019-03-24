//
//  MenuCategory.swift
//  MARS
//
//  Created by Mac on 3/24/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import Foundation

enum Category {
    case events, comms, hydro, ls, transit, fun
}

struct MenuCategory {
    var category: Category
    var name: String
    var iconName: String
    
    init(_ category: Category) {
        self.category = category
        var nameString: String {
            switch category {
            case .events:
                return "Events"
            case .comms:
                return "Comms"
            case .hydro:
                return "Weather"
            case .ls:
                return "LS"
            case .transit:
                return "Transit"
            case .fun:
                return "Fun"
            }
        }
        self.name = nameString
        self.iconName = nameString.lowercased()
    }
    
}

