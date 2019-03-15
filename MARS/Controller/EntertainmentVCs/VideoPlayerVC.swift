//
//  VideoPlayerVC.swift
//  MARS
//
//  Created by Mac on 3/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerVC: BasePlayerVC {
    
    var videoPlayer: AVPlayer?
    var videoLayer: AVPlayerLayer?
    
    var wasCurrentlyPlaying: Bool?
    
    let videoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoView()
        setupVideoPlayer()
        setupBackButtonLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoLayer!.frame = videoView.frame
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isPlaying = false
        videoPlayer?.pause()
        super.viewWillDisappear(animated)
    }
    
    override func addMediaControls() {
        view.addSubview(videoView)
        super.addMediaControls()
    }
    
    override func playPause() {
        if isPlaying {
            videoPlayer?.pause()
        } else {
            videoPlayer?.play()
        }
        super.playPause()
    }
    
    private func fadeMediaControls() {
        if playPauseButton.alpha == 0 {
            goBackButton.fadeIn(duration: 1)
            slider.fadeIn(duration: 1)
            playPauseButton.fadeIn(duration: 1)
        } else if playPauseButton.alpha == 1 {
            goBackButton.fadeOut(duration: 1)
            slider.fadeOut(duration: 1)
            playPauseButton.fadeOut(duration: 1)
        }
    }
    
    private func setupVideoPlayer() {
        guard let path = Bundle.main.path(forResource: "stockVideo", ofType: ".mp4") else { return }
        let url = URL(fileURLWithPath: path)
        
        videoPlayer = AVPlayer(url: url)
        videoLayer = AVPlayerLayer(player: videoPlayer)
        videoView.layer.addSublayer(videoLayer!)
        videoLayer!.videoGravity = .resizeAspectFill
        videoView.fadeIn(duration: 2)
        
        videoPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        let observerInterval = CMTime(value: 1, timescale: 1)
        videoPlayer?.addPeriodicTimeObserver(forInterval: observerInterval, queue: DispatchQueue.main, using: { (currentTime) in
            self.currentTimeLabel.text = self.getFormattedTimeString(for: currentTime)
            self.moveSliderTo(currentTime: currentTime)
        })
        
        slider.addTarget(self, action: #selector(trackCurrentPlayerState), for: .touchDown)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(resumePlayerState), for: .touchUpInside)
        
        let videoViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapVideoView))
        videoView.addGestureRecognizer(videoViewTapGestureRecognizer)
    }
        
    private func moveSliderTo(currentTime: CMTime) {
        if let videoDuration = videoPlayer?.currentItem?.duration {
            let value = Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(videoDuration))
            self.slider.setValue(value, animated: true)
        }
    }
    
    @objc private func didTapVideoView() {
        fadeMediaControls()
    }
    
    @objc private func trackCurrentPlayerState() {
        videoPlayer?.pause()
        wasCurrentlyPlaying = isPlaying
        isPlaying = false
    }
    
    @objc private func resumePlayerState() {
        isPlaying = wasCurrentlyPlaying
        if wasCurrentlyPlaying! {
            videoPlayer?.play()
        } else {
            videoPlayer?.pause()
        }
    }
    
    @objc private func sliderValueChanged() {
        if let videoDuration = videoPlayer?.currentItem?.duration {
            let time = Float64(slider.value) * CMTimeGetSeconds(videoDuration)
            let gotoTime = CMTime(value: Int64(time), timescale: 1)
            videoPlayer?.seek(to: gotoTime, completionHandler: { (_) in
            })
        }
        if slider.value == 1 {
            isPlaying = false
            fadeMediaControls()
            videoPlayer?.seek(to: CMTime(seconds: 0, preferredTimescale: 1), completionHandler: { (_) in
                self.slider.setValue(0, animated: true)
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            if let videoDuration = videoPlayer?.currentItem?.duration {
                totalTimeLabel.text = getFormattedTimeString(for: videoDuration)
            }
            
            showMediaControls()
            
            videoPlayer?.play()
            isPlaying = true
        }
    }
    
    private func setupVideoView() {
        videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        videoView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func setupMediaControlsLayout() {
        slider.bottomAnchor.constraint(equalTo: videoView.bottomAnchor, constant: -10).isActive = true
        slider.leadingAnchor.constraint(equalTo: videoView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        slider.trailingAnchor.constraint(equalTo: videoView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true

        currentTimeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        currentTimeLabel.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 5).isActive = true

        totalTimeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        totalTimeLabel.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 5).isActive = true

        playPauseButton.centerXAnchor.constraint(equalTo: videoView.centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: videoView.centerYAnchor).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    func setupBarItem() {
        let image = #imageLiteral(resourceName: "video-icon")
        tabBarItem = UITabBarItem(title: "Video", image: image, tag: 2)
    }

}
