//
//  EntertainmentVC.swift
//  MARS
//
//  Created by Mac on 3/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class EntertainmentVC: UITabBarController {
    
    let goBackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = #imageLiteral(resourceName: "back-icon").withRenderingMode(.alwaysTemplate)
        button.imageView?.tintColor = UIColor.white
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Themes.currentTheme.secondaryColor
        setupTabBar()
        setupbackButtonLayout()
    }
    
    func setupbackButtonLayout() {
        view.addSubview(goBackButton)
        goBackButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        goBackButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        goBackButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupTabBar() {
        let musicPlayer = MusicPlayerVC()
        let videoPlayer = VideoPlayerVC()
        let activitiesVCLayout = UICollectionViewFlowLayout()
        let activities = ActivitiesVC(collectionViewLayout: activitiesVCLayout)

        viewControllers = [activities, musicPlayer, videoPlayer]
        selectedViewController = activities
        tabBar.barTintColor = Themes.currentTheme.primaryColor
        tabBar.tintColor = Themes.currentTheme.primaryAccentColor
        activities.setupBarItem()
        musicPlayer.setupBarItem()
        videoPlayer.setupBarItem()
    }
    
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

}
