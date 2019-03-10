//
//  EntertainmentVC.swift
//  MARS
//
//  Created by Mac on 3/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class EntertainmentVC: UITabBarController {
    
    let musicPlayer = MusicPlayerVC()
    let videoPlayer = VideoPlayerVC()
    let activities = ActivitiesVC()
    
    let goBackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = #imageLiteral(resourceName: "back-icon").withRenderingMode(.alwaysTemplate)
        button.imageView?.tintColor = primaryColor
        button.setImage(image, for: .normal)
        button.alpha = 0
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = primaryColor
        
        setupTabBar()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goBackButton.fadeIn(duration: 1)
    }
    
    private func setupLayout() {
        view.addSubview(goBackButton)
        goBackButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        goBackButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        goBackButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupTabBar() {
        viewControllers = [musicPlayer, videoPlayer, activities]
        selectedViewController = musicPlayer
        tabBar.tintColor = primaryRedColor
        musicPlayer.setupBarItem()
        videoPlayer.setupBarItem()
        activities.setupBarItem()
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
}
