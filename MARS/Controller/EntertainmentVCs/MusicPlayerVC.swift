//
//  MusicPlayerVC.swift
//  MARS
//
//  Created by Mac on 3/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerVC: BasePlayerVC {
    
    var musicPlayer: AVPlayer?
    
    var wasCurrentlyPlaying: Bool?

    var isLoaded: Bool! = false
    
    
    let albumCoverView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "album-cover")
        
        return imageView
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Themes.currentTheme.secondaryColor
        attributionLabel.text = "photo by Eutah Mizushima via pixabay.com\noriginal track"
        attributionLabel.textColor = Themes.currentTheme.tertiaryFontColor
        setupAlbumCoverLayout()
        setupLayout()
    }
    
    var portraitConstraints = [NSLayoutConstraint]()
    var landscapeConstraints = [NSLayoutConstraint]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isLoaded {
            getData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if view.frame.height > view.frame.width {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
        } else {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isPlaying = false
        musicPlayer?.pause()
        super.viewWillDisappear(animated)
    }
    
    override func hideMediaControls() {
        super.hideMediaControls()
        albumCoverView.alpha = 0
        albumCoverView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    override func showMediaControls() {
        super.showMediaControls()
        albumCoverView.fadeIn(duration: 2)
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.albumCoverView.transform = .identity
        })
    }
    
    private func getData() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.setupMusicPlayer()

            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
            self?.attributionLabel.fadeIn(duration: 0.5)
            self?.showMediaControls()
            self?.isLoaded = true
        }
    }
    
    override func addMediaControls() {
        view.addSubview(albumCoverView)
        view.addSubview(controlsContainerView)
        controlsContainerView.addSubview(slider)
        controlsContainerView.addSubview(currentTimeLabel)
        controlsContainerView.addSubview(totalTimeLabel)
        controlsContainerView.addSubview(playPauseButton)
    }
    
    override func setupMediaControlsLayout() {
        setupControlsContainerLayout()
        slider.centerYAnchor.constraint(equalTo: controlsContainerView.topAnchor, constant: 50).isActive = true
        slider.leadingAnchor.constraint(equalTo: controlsContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        slider.trailingAnchor.constraint(equalTo: controlsContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        
        currentTimeLabel.centerXAnchor.constraint(equalTo: controlsContainerView.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -5).isActive = true
        
        totalTimeLabel.centerXAnchor.constraint(equalTo: controlsContainerView.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        totalTimeLabel.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -5).isActive = true
        
        playPauseButton.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor, constant: -20).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupAlbumCoverLayout() {
        albumCoverView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        albumCoverView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        portraitConstraints.append(albumCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        landscapeConstraints.append(albumCoverView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20))

        portraitConstraints.append(albumCoverView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -20))
        landscapeConstraints.append(albumCoverView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20))
        
        view.addSubview(attributionLabel)
        attributionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        attributionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    

    private func setupControlsContainerLayout() {
        controlsContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        controlsContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        portraitConstraints.append(controlsContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        landscapeConstraints.append(controlsContainerView.leadingAnchor.constraint(equalTo: albumCoverView.trailingAnchor))
        
        portraitConstraints.append(controlsContainerView.topAnchor.constraint(equalTo: albumCoverView.bottomAnchor, constant: 15))
        landscapeConstraints.append(controlsContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15))
    }
    
    override func playPause() {
        if isPlaying {
            musicPlayer?.pause()
        } else {
            musicPlayer?.play()
        }
        super.playPause()
    }
    
    private func setupMusicPlayer() {
        guard let path = Bundle.main.path(forResource: "not-of-this-earth", ofType: ".mp3") else { return }
        let url = URL(fileURLWithPath: path)
        
        musicPlayer = AVPlayer(url: url)
        
        musicPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        let observerInterval = CMTime(value: 1, timescale: 1)
        musicPlayer?.addPeriodicTimeObserver(forInterval: observerInterval, queue: DispatchQueue.main, using: { [weak self] (currentTime) in
            self?.currentTimeLabel.text = self?.getFormattedTimeString(for: currentTime)
            self?.moveSliderTo(currentTime: currentTime)
        })
        
        slider.addTarget(self, action: #selector(trackCurrentPlayerState), for: .touchDown)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(resumePlayerState), for: .touchUpInside)
    }
    
    private func moveSliderTo(currentTime: CMTime) {
        if let songDuration = musicPlayer?.currentItem?.duration {
            let value = Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(songDuration))
            self.slider.setValue(value, animated: true)
        }
    }
    
    @objc private func trackCurrentPlayerState() {
        musicPlayer?.pause()
        wasCurrentlyPlaying = isPlaying
        isPlaying = false
    }
    
    @objc private func resumePlayerState() {
        isPlaying = wasCurrentlyPlaying
        if wasCurrentlyPlaying! {
            musicPlayer?.play()
        } else {
            musicPlayer?.pause()
        }
    }
    
    @objc private func sliderValueChanged() {
        if let videoDuration = musicPlayer?.currentItem?.duration {
            let time = Float64(slider.value) * CMTimeGetSeconds(videoDuration)
            let gotoTime = CMTime(value: Int64(time), timescale: 1)
            musicPlayer?.seek(to: gotoTime, completionHandler: { (_) in
            })
        }
        if slider.value == 1 {
            isPlaying = false
            musicPlayer?.seek(to: CMTime(seconds: 0, preferredTimescale: 1), completionHandler: { (_) in
                self.slider.setValue(0, animated: true)
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            if let songDuration = musicPlayer?.currentItem?.duration {
                totalTimeLabel.text = getFormattedTimeString(for: songDuration)
            }
            
            musicPlayer?.play()
            isPlaying = true
        }
    }
    
    func setupBarItem() {
        let image = #imageLiteral(resourceName: "audio-icon")
        tabBarItem = UITabBarItem(title: "Audio", image: image, tag: 1)
    }
    
}
