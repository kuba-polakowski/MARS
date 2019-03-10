//
//  VideoPlayerVC.swift
//  MARS
//
//  Created by Mac on 3/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class VideoPlayerVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    func setupBarItem() {
        let image = #imageLiteral(resourceName: "video-icon")
        tabBarItem = UITabBarItem(title: "Video", image: image, tag: 2)
    }

}
