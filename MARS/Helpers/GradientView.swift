//
//  GradientView.swift
//  MARS
//
//  Created by Mac on 2/26/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class GradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
