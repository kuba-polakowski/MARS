//
//  EntertainmentVC.swift
//  MARS
//
//  Created by Mac on 3/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class EntertainmentVC: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = currentTheme.primaryColor
        tabBar.barTintColor = currentTheme.primaryColor
        setupTabBar()
    }
    
    private func setupTabBar() {
        let musicPlayer = MusicPlayerVC()
        let videoPlayer = VideoPlayerVC()
        let activitiesVCLayout = UICollectionViewFlowLayout()
        let activities = ActivitiesVC(collectionViewLayout: activitiesVCLayout)

        viewControllers = [activities, musicPlayer, videoPlayer]
        selectedViewController = activities
        tabBar.tintColor = currentTheme.tertiaryAccentColor
        activities.setupBarItem()
        musicPlayer.setupBarItem()
        videoPlayer.setupBarItem()
    }
    
}
