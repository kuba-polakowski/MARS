//
//  DateFormatter.swift
//  MARS
//
//  Created by Mac on 2/18/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import Foundation

extension Date {
    
    static func fromString(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: dateString) ?? Date()
    }
    
    func asString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
}
