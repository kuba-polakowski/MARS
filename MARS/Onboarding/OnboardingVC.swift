//
//  OnboardingVC.swift
//  MARS
//
//  Created by Mac on 3/4/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit
import AVFoundation

class OnboardingVC: UIViewController {
    
    var currentPage = 0
    
    var avPlayer: AVQueuePlayer?
    var avLooper: AVPlayerLooper?
    var avLayer: AVPlayerLayer?
    
    let videoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0

        return view
    }()
    
    let fadeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, secondaryRedColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.8)
        
        return gradientLayer
    }()
    
    let pageIndicatorDots: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        for page in onboardingSubtitles {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            let image = #imageLiteral(resourceName: "dot").withRenderingMode(.alwaysTemplate)
            imageView.image = image
            
            stackView.addArrangedSubview(imageView)
        }
        
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 200, weight: .bold)
        label.textColor = primaryColor
        label.text = "MARS"
        label.alpha = 0
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = secondaryColor
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.alpha = 0
        
        return label
    }()
    
    let descriptionLabelContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = primaryColor
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = primaryRedColor
        button.layer.cornerRadius = 17
        button.titleLabel?.textColor = primaryColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitle("Done!", for: .normal)
        button.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        button.alpha = 0
        
        return button
    }()
    
    var subtitleConstraint: NSLayoutConstraint!
    var descriptionTopConstraint: NSLayoutConstraint!
    var descriptionBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = tertiaryRedColor
        
        view.addSubview(videoView)
        videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        videoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(fadeView)
        fadeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fadeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        fadeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fadeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        fadeView.layer.addSublayer(gradientLayer)
        
        view.addSubview(pageIndicatorDots)
        pageIndicatorDots.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        pageIndicatorDots.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pageIndicatorDots.heightAnchor.constraint(equalToConstant: 300).isActive = true
        pageIndicatorDots.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -100).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 100).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        view.addSubview(subtitleLabel)
        subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        
        subtitleConstraint = subtitleLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -20)
        subtitleConstraint.isActive = true
        
        view.addSubview(descriptionLabelContainer)
        descriptionLabelContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        descriptionLabelContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
        
        descriptionBottomConstraint = descriptionLabelContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        descriptionBottomConstraint.isActive = true
        descriptionTopConstraint = descriptionLabelContainer.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        descriptionTopConstraint.isActive = true
        
        descriptionLabelContainer.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: descriptionLabelContainer.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: descriptionLabelContainer.topAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: descriptionLabelContainer.trailingAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(lessThanOrEqualTo: descriptionLabelContainer.heightAnchor).isActive = true
        
        view.addSubview(doneButton)
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp))
        swipeUpGestureRecognizer.direction = .up
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown))
        swipeDownGestureRecognizer.direction = .down
        
        view.addGestureRecognizer(swipeUpGestureRecognizer)
        view.addGestureRecognizer(swipeDownGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subtitleLabel.text = onboardingSubtitles[currentPage]
        descriptionLabel.text = onboardingDescriptions[currentPage]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupVideoPlayer()
        setupGradient()
        titleLabel.fadeIn(duration: 2)
        setupPage()
        setupPageDot()
        showLabels(forward: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupGradient()
        avLayer?.frame = videoView.frame
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    private func setupVideoPlayer() {
        guard let path = Bundle.main.path(forResource: "onboardingVideo", ofType: ".mp4") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        
        avPlayer = AVQueuePlayer(items: [item])
        avPlayer!.volume = 0.0
        
        avLooper = AVPlayerLooper(player: avPlayer!, templateItem: item)
        
        avLayer = AVPlayerLayer(player: avPlayer)
        avLayer!.frame = videoView.frame
        videoView.layer.addSublayer(avLayer!)
        avLayer!.videoGravity = .resizeAspectFill
        avPlayer!.play()
        
        videoView.fadeIn(duration: 3)
    }
    
    @objc private func didSwipeUp() {
        guard currentPage < onboardingSubtitles.count - 1 else { return }
        view.isUserInteractionEnabled = false
        currentPage += 1
        
        setupPageDot()
        hideLabels(forward: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            self.setupPage()
            self.showLabels(forward: true)
        }
        if currentPage == onboardingSubtitles.count - 1 {
            doneButton.fadeIn(duration: 2)
        }
    }
    
    @objc private func didSwipeDown() {
        guard currentPage > 0 else { return }
        view.isUserInteractionEnabled = false
        currentPage -= 1

        setupPageDot()
        hideLabels(forward: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            self.setupPage()
            self.showLabels(forward: false)
        }
    }
    
    @objc private func doneButtonPressed() {
        hideLabels(forward: true)
        doneButton.fadeOut(duration: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.dismiss(animated: true, completion: nil)
        }
    }
        
    private func setupPage() {
        subtitleLabel.text = onboardingSubtitles[currentPage]
        descriptionLabel.text = onboardingDescriptions[currentPage]
    }
    
    private func setupPageDot() {
        UIView.animate(withDuration: 1) { [unowned self] in
            (self.pageIndicatorDots.subviews as! [UIImageView]).forEach { (imageView) in
                imageView.tintColor = secondaryColor
            }
            (self.pageIndicatorDots.subviews[self.currentPage] as! UIImageView).tintColor = primaryRedColor
        }
    }
    
    func showLabels(forward: Bool) {
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.subtitleConstraint.constant = -40
            self?.view.layoutIfNeeded()
            self?.subtitleLabel.alpha = 1
        })
        
        UIView.animate(withDuration: 0.8, delay: 0.5, options: .curveEaseInOut, animations: { [weak self] in
            self?.descriptionBottomConstraint.constant = -10
            self?.descriptionTopConstraint.constant = 80
            self?.view.layoutIfNeeded()
            self?.descriptionLabelContainer.alpha = 1
        }) { (_) in
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func hideLabels(forward: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.subtitleConstraint.constant = forward ? -60 : -20
            self?.view.layoutIfNeeded()
            self?.subtitleLabel.alpha = 0
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut, animations: { [weak self] in
            self?.descriptionBottomConstraint.constant = forward ? -30 : 10
            self?.descriptionTopConstraint.constant = forward ? 60 : 100
            self?.view.layoutIfNeeded()
            self?.descriptionLabelContainer.alpha = 0
        }) { (_) in
            self.resetLabelConstraints(forward: forward)
        }
        
    }
    
    func resetLabelConstraints(forward: Bool) {
        subtitleConstraint.constant = forward ? -20 : -60
        descriptionBottomConstraint.constant = forward ? 10 : -30
        descriptionTopConstraint.constant = forward ? 100 : 60
        view.layoutIfNeeded()
    }
    
    private func setupGradient() {
        gradientLayer.frame = view.frame
    }
        
}
