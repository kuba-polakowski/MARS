//
//  EventDetailVC.swift
//  MARS
//
//  Created by Mac on 2/19/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class EventDetailVC: UIViewController {
    
    var animationOffset: CGFloat!
    
    var event: Event! {
        didSet {
            thumbnailView.image = UIImage(named: event.imageName)
            eventView.thumbnailView.image = UIImage(named: event.imageName)
            eventView.titleLabel.text = event.title
            eventView.dateLabel.text = event.date.asString()
            detailLabel.text = event.details
        }
    }
    
    let addReminderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = secondaryRedColor
        button.layer.cornerRadius = 17
        button.titleLabel?.textColor = primaryColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitle("Set Reminder", for: .normal)
        button.addTarget(self, action: #selector(addEventReminder), for: .touchUpInside)
        button.alpha = 0
        
        return button
    }()
    
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
    
    let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let eventView: BaseEventView = {
        let eventView = BaseEventView()
        eventView.translatesAutoresizingMaskIntoConstraints = false
        eventView.backgroundColor = primaryColor
        
        return eventView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = primaryFontColor
        label.alpha = 0
        
        return label
    }()

    var eventViewTopConstraint: NSLayoutConstraint!
    var thumbnailTopConstraint: NSLayoutConstraint!
    var thumbnailHeightConstraint: NSLayoutConstraint!
    var reminderButtonTopConstraint: NSLayoutConstraint!
    var reminderButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = primaryColor
        
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(eventView)
        eventView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        eventView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        eventView.heightAnchor.constraint(equalToConstant: 325).isActive = true
        
        eventViewTopConstraint = eventView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        eventViewTopConstraint.isActive = true
        
        eventView.animateForTransition(withInsets: view.safeAreaInsets)
        
        scrollView.addSubview(detailLabel)
        detailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        detailLabel.topAnchor.constraint(equalTo: eventView.bottomAnchor, constant: 15).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -35).isActive = true
        
        scrollView.addSubview(thumbnailView)
        
        thumbnailTopConstraint = thumbnailView.topAnchor.constraint(equalTo: view.topAnchor)
        thumbnailTopConstraint.priority = .defaultHigh
        thumbnailTopConstraint.isActive = true
        
        thumbnailHeightConstraint = thumbnailView.heightAnchor.constraint(greaterThanOrEqualToConstant: 230)
        thumbnailHeightConstraint.priority = .required
        thumbnailHeightConstraint.isActive = true
        
        thumbnailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        thumbnailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        thumbnailView.bottomAnchor.constraint(equalTo: eventView.topAnchor, constant: 230).isActive = true
        
        view.addSubview(goBackButton)
        goBackButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        goBackButton.topAnchor.constraint(equalTo: thumbnailView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        goBackButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        goBackButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        scrollView.addSubview(addReminderButton)
        reminderButtonTopConstraint = addReminderButton.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        reminderButtonTopConstraint.priority = .required
        reminderButtonTopConstraint.isActive = true
        
        reminderButtonBottomConstraint = addReminderButton.bottomAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: -10)
        reminderButtonBottomConstraint.priority = .defaultHigh
        reminderButtonBottomConstraint.isActive = true
        
        addReminderButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        addReminderButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        addReminderButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventView.dateLabelLeadingConstraint.constant = view.frame.width - 140
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goBackButton.fadeIn(duration: 0.5)
        detailLabel.fadeIn(duration: 1)
        addReminderButton.fadeIn(duration: 1.5)
    }
    
    @objc private func addEventReminder() {
        print("ADDING A REMINDER TO CALENDAR")
    }
    
    @objc private func goBack() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        thumbnailView.alpha = 0
        goBackButton.fadeOut(duration: 0.3)
        detailLabel.fadeOut(duration: 0.5)
        addReminderButton.fadeOut(duration: 0.7)
        eventViewTopConstraint.constant = animationOffset
        eventView.setOriginalConstraints()

        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseInOut, animations: { [unowned self] in
            self.view.layoutIfNeeded()
        }) { (_) in
            self.eventView.clipsToBounds = true
            self.dismiss(animated: true, completion: nil)
        }
    }
}
