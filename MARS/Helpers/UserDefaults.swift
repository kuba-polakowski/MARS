//
//  UserSettings.swift
//  MARS
//
//  Created by Mac on 3/5/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import Foundation


extension UserDefaults {
    

    enum keys: String {
        case onboarding
        case temperatureScale
        case theme
    }
    
    func setOnboardingDone() {
        set(true, forKey: keys.onboarding.rawValue)
        synchronize()
    }
    
    func isOnboardingDone() -> Bool {
        return bool(forKey: keys.onboarding.rawValue)
    }
    
    func setTemperatureScaleToCelsius(_ bool: Bool) {
        set(bool, forKey: keys.temperatureScale.rawValue)
        synchronize()
    }
    
    func currentTemperatureScaleIsCelsius() -> Bool {
        return bool(forKey: keys.temperatureScale.rawValue)
    }
    
    func setThemeIsLight(_ bool: Bool) {
        set(bool, forKey: keys.theme.rawValue)
        synchronize()
    }
    
    func isThemeLight() -> Bool {
        return bool(forKey: keys.theme.rawValue)
    }

}
