//
//  FadeAnimations.swift
//  MARS
//
//  Created by Mac on 2/19/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

extension UIView {
    func fadeOut(duration: Double) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 0
        })
    }
    
    func fadeIn(duration: Double) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.alpha = 1
        })
    }
}
