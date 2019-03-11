//
//  MusicPlayerVC.swift
//  MARS
//
//  Created by Mac on 3/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class MusicPlayerVC: UIViewController {
    
    let playImage = #imageLiteral(resourceName: "play-icon").withRenderingMode(.alwaysTemplate)
    let pauseImage = #imageLiteral(resourceName: "pause-icon").withRenderingMode(.alwaysTemplate)
    
    var isPlaying: Bool! {
        didSet {
            setupPlayButtonImage()
        }
    }
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = secondaryFontColor
        
        return label
    }()
    
    let totalTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = secondaryFontColor
        
        return label
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = tertiaryRedColor
        slider.thumbTintColor = tertiaryRedColor
        slider.value = 0.3
        
        return slider
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = tertiaryRedColor
        button.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = primaryColor
        isPlaying = false
        
        setupBarItem()
        setupMediaControls()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTotalTime()
        setupCurrentTime()
    }
    
    private func setupMediaControls() {
        view.addSubview(slider)
        slider.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        
        view.addSubview(currentTimeLabel)
        currentTimeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -5).isActive = true
        
        view.addSubview(totalTimeLabel)
        totalTimeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        totalTimeLabel.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -5).isActive = true
        
        view.addSubview(playPauseButton)
        playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupBarItem() {
        let image = #imageLiteral(resourceName: "audio-icon")
        tabBarItem = UITabBarItem(title: "Audio", image: image, tag: 1)
    }
    
    private func setupTotalTime() {
        totalTimeLabel.text = "04:55"
    }
    
    private func setupCurrentTime() {
        currentTimeLabel.text = "01:48"
    }
    
    private func setupPlayButtonImage() {
        let image = isPlaying ? pauseImage : playImage
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.playPauseButton.setImage(image, for: .normal)
        }
    }
    
    @objc private func playPause() {
        isPlaying = !isPlaying
    }

}
