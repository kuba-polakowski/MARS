//
//  MusicPlayerVC.swift
//  MARS
//
//  Created by Mac on 3/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class MusicPlayerVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    func setupBarItem() {
        let image = #imageLiteral(resourceName: "audio-icon")
        tabBarItem = UITabBarItem(title: "Audio", image: image, tag: 1)
    }

}
