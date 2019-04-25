//
//  Theme.swift
//  MARS
//
//  Created by Mac on 3/25/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

struct Theme {
    let primaryColor: UIColor
    let secondaryColor: UIColor

    let primaryFontColor: UIColor
    let secondaryFontColor: UIColor
    let tertiaryFontColor: UIColor

    let primaryAccentColor: UIColor
    let secondaryAccentColor: UIColor
    let tertiaryAccentColor: UIColor
    
    let isLight: Bool
    
    let posterName: String
    
    init(isLight: Bool, posterName: String, _ primaryColor: UIColor, _ secondaryColor: UIColor, _ primaryFontColor: UIColor, _ secondaryFontColor: UIColor, _ tertiaryFontColor: UIColor, _ primaryAccentColor: UIColor, _ secondaryAccentColor: UIColor, _ tertiaryAccentColor: UIColor) {
        self.isLight = isLight
        self.posterName = posterName
        
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.primaryFontColor = primaryFontColor
        self.secondaryFontColor = secondaryFontColor
        self.tertiaryFontColor = tertiaryFontColor
        self.primaryAccentColor = primaryAccentColor
        self.secondaryAccentColor = secondaryAccentColor
        self.tertiaryAccentColor = tertiaryAccentColor
    }
}
