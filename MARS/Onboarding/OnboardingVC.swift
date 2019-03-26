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
        gradientLayer.colors = [UIColor.clear.cgColor, currentTheme.secondaryAccentColor.cgColor]
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
        label.textColor = currentTheme.primaryColor
        label.text = "MARS"
        label.alpha = 0
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = currentTheme.secondaryColor
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
        label.textColor = currentTheme.primaryColor
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = currentTheme.primaryAccentColor
        button.layer.cornerRadius = 17
        button.titleLabel?.textColor = currentTheme.primaryColor
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
        view.backgroundColor = currentTheme.tertiaryAccentColor
        
        setupViews()
        setupLayout()
        setupGestureRecognizers()
        setupTextForCurrentPage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupVideoPlayer()
        titleLabel.fadeIn(duration: 2)
        setupTextForCurrentPage()
        setupCurrentPageDot()
        showLabels(forward: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupGradientFrame()
        avLayer?.frame = videoView.frame
    }
    
    private func setupViews() {
        view.addSubview(videoView)
        view.addSubview(fadeView)
        fadeView.layer.addSublayer(gradientLayer)
        view.addSubview(pageIndicatorDots)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(descriptionLabelContainer)
        descriptionLabelContainer.addSubview(descriptionLabel)
        view.addSubview(doneButton)
    }
    
    private func setupLayout() {
        videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        videoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        fadeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fadeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        fadeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fadeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        pageIndicatorDots.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        pageIndicatorDots.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pageIndicatorDots.heightAnchor.constraint(equalToConstant: 300).isActive = true
        pageIndicatorDots.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -100).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 100).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        
        subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        
        subtitleConstraint = subtitleLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -20)
        subtitleConstraint.isActive = true
        
        
        descriptionLabelContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        descriptionLabelContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
        
        descriptionBottomConstraint = descriptionLabelContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        descriptionBottomConstraint.isActive = true
        descriptionTopConstraint = descriptionLabelContainer.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        descriptionTopConstraint.isActive = true
        
        
        descriptionLabel.leadingAnchor.constraint(equalTo: descriptionLabelContainer.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: descriptionLabelContainer.topAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: descriptionLabelContainer.trailingAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(lessThanOrEqualTo: descriptionLabelContainer.heightAnchor).isActive = true
        
        
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    private func setupGestureRecognizers() {
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp))
        swipeUpGestureRecognizer.direction = .up
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown))
        swipeDownGestureRecognizer.direction = .down
        
        view.addGestureRecognizer(swipeUpGestureRecognizer)
        view.addGestureRecognizer(swipeDownGestureRecognizer)
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
        
        videoView.fadeIn(duration: 5)
    }
    
    @objc private func didSwipeUp() {
        guard currentPage < onboardingSubtitles.count - 1 else { return }
        didSwipe(forward: true)
    }
    
    @objc private func didSwipeDown() {
        guard currentPage > 0 else { return }
        didSwipe(forward: false)
    }
    
    @objc private func doneButtonPressed() {
        hideLabels(forward: true)
        doneButton.fadeOut(duration: 1)
        UserDefaults.standard.setOnboardingDone()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func didSwipe(forward: Bool) {
        view.isUserInteractionEnabled = false
        currentPage += forward ? 1 : -1
        setupCurrentPageDot()
        hideLabels(forward: forward)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            self.setupTextForCurrentPage()
            self.showLabels(forward: forward)
        }
        if currentPage == onboardingSubtitles.count - 1 {
            doneButton.fadeIn(duration: 2)
        }
    }
        
    private func setupTextForCurrentPage() {
        subtitleLabel.text = onboardingSubtitles[currentPage]
        descriptionLabel.text = onboardingDescriptions[currentPage]
    }
    
    private func setupCurrentPageDot() {
        UIView.animate(withDuration: 1) { [unowned self] in
            (self.pageIndicatorDots.subviews as! [UIImageView]).forEach { (imageView) in
                imageView.tintColor = currentTheme.secondaryColor
            }
            (self.pageIndicatorDots.subviews[self.currentPage] as! UIImageView).tintColor = currentTheme.primaryAccentColor
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
    
    private func setupGradientFrame() {
        gradientLayer.frame = view.frame
    }
        
}
