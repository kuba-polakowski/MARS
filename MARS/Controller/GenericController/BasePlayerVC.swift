//
//  BasePlayerVC.swift
//  MARS
//
//  Created by Mac on 3/11/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit
import AVFoundation

class BasePlayerVC: UIViewController {
    
    let playImage = #imageLiteral(resourceName: "play-icon").withRenderingMode(.alwaysTemplate)
    let pauseImage = #imageLiteral(resourceName: "pause-icon").withRenderingMode(.alwaysTemplate)
    
    var isPlaying: Bool! {
        didSet {
            setupPlayButtonImage()
        }
    }
    
    let goBackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = #imageLiteral(resourceName: "back-icon").withRenderingMode(.alwaysTemplate)
        button.imageView?.tintColor = primaryColor
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return button
    }()
    
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
        isPlaying = false
        
        addMediaControls()
        setupMediaControlsLayout()
        hideMediaControls()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showMediaControls()
    }
    
    func addMediaControls() {
        view.addSubview(slider)
        view.addSubview(currentTimeLabel)
        view.addSubview(totalTimeLabel)
        view.addSubview(playPauseButton)
    }
    
    func setupMediaControlsLayout() {
    }
    
    func setupBackButtonLayout() {
        view.addSubview(goBackButton)
        goBackButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        goBackButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        goBackButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setupPlayButtonImage() {
        let currentImage = playPauseButton.image(for: .normal) ?? playImage
        let image = isPlaying ? pauseImage : playImage
        let imageFadeAnimation = CABasicAnimation(keyPath: "contents")
        imageFadeAnimation.duration = 0.1
        imageFadeAnimation.fromValue = currentImage.cgImage
        imageFadeAnimation.toValue = image.cgImage
        playPauseButton.imageView?.layer.add(imageFadeAnimation, forKey: "animateButtonImage")
        playPauseButton.setImage(image, for: .normal)
    }

    func hideMediaControls() {
        goBackButton.alpha = 0
        slider.alpha = 0
        currentTimeLabel.alpha = 0
        totalTimeLabel.alpha = 0
        playPauseButton.alpha = 0
    }
    
    func showMediaControls() {
        goBackButton.fadeIn(duration: 0.5)
        slider.fadeIn(duration: 1.5)
        currentTimeLabel.fadeIn(duration: 2)
        totalTimeLabel.fadeIn(duration: 2.5)
        playPauseButton.fadeIn(duration: 3)
    }

    @objc func playPause() {
        isPlaying = !isPlaying
    }
    
    func getFormattedTimeString(for time: CMTime) -> String {
        let totalSeconds = Int(CMTimeGetSeconds(time))
        
        let seconds = totalSeconds % 60
        let minutes = (totalSeconds - seconds) / 60
        
        let secondsString = String(format: "%02d", seconds)
        let minutesString = String(format: "%02d", minutes)
        
        return minutesString + ":" + secondsString
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

}
