//
//  NavigationControllerExtension.swift
//  MARS
//
//  Created by Mac on 3/3/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

extension UINavigationController {
    override open var preferredStatusBarStyle : UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
