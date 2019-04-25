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
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = Themes.currentTheme.secondaryFontColor
        
        return label
    }()
    
    let totalTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = Themes.currentTheme.secondaryFontColor
        
        return label
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.tintColor = Themes.currentTheme.tertiaryAccentColor
        slider.thumbTintColor = Themes.currentTheme.tertiaryAccentColor
        
        return slider
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Themes.currentTheme.tertiaryAccentColor
        button.addTarget(self, action: #selector(playPause), for: .touchUpInside)
        
        return button
    }()

    let attributionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.alpha = 0
        
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.isHidden = true
        activityIndicatorView.color = Themes.currentTheme.primaryAccentColor
        
        return activityIndicatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        isPlaying = false
        
        addMediaControls()
        setupMediaControlsLayout()
        hideMediaControls()
    }
    
    func addMediaControls() {
        view.addSubview(slider)
        view.addSubview(currentTimeLabel)
        view.addSubview(totalTimeLabel)
        view.addSubview(playPauseButton)
    }
    
    func setupMediaControlsLayout() {
    }
    
    func setupLayout() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
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
        slider.alpha = 0
        currentTimeLabel.alpha = 0
        totalTimeLabel.alpha = 0
        playPauseButton.alpha = 0
    }
    
    func showMediaControls() {
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

}
