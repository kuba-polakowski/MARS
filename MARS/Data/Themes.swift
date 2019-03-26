//
//  Themes.swift
//  MARS
//
//  Created by Mac on 3/25/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import Foundation

let lightTheme = Theme(isLight: true, posterName: "Mars", lightThemePrimaryColor, lightThemeSecondaryColor, lightThemePrimaryFontColor, lightThemeSecondaryFontColor, lightThemeTertiaryFontColor, lightThemePrimaryAccentColor, lightThemeSecondaryAccentColor, lightThemeTertiaryAccentColor)

let darkTheme = Theme(isLight: false, posterName: "Europa", darkThemePrimaryColor, darkThemeSecondaryColor, darkThemePrimaryFontColor, darkThemeSecondaryFontColor, darkThemeTertiaryFontColor, darkThemePrimaryAccentColor, darkThemeSecondaryAccentColor, darkThemeTertiaryAccentColor)

var currentTheme = lightTheme
