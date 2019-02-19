//
//  EventDetailVC.swift
//  MARS
//
//  Created by Mac on 2/19/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class EventDetailVC: UIViewController {
    
    var event: Event! {
        didSet {
            thumbnailView.image = UIImage(named: event.imageName)
            eventView.titleLabel.text = event.title
            eventView.dateLabel.text = event.date.asString()
            detailLabel.text = event.details
        }
    }
    
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
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = primaryFontColor
        label.alpha = 0
        
        return label
    }()

    var thumbnailTopConstraint: NSLayoutConstraint!
    var thumbnailHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = primaryColor
        
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(eventView)
        eventView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        eventView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        eventView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        eventView.heightAnchor.constraint(equalToConstant: 325).isActive = true
        
        eventView.animateForTransition()
        
        scrollView.addSubview(detailLabel)
        detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        detailLabel.topAnchor.constraint(equalTo: eventView.bottomAnchor, constant: 15).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30).isActive = true
        
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

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventView.dateLabelLeadingConstraint.constant = view.frame.width - 140
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        detailLabel.fadeIn(duration: 1)
    }
}
