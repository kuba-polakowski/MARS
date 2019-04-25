//
//  EventDetailVC.swift
//  MARS
//
//  Created by Mac on 2/19/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit
import EventKit

class EventDetailVC: UIViewController {
    
    var animationOffset: CGFloat!
    
    let store = EKEventStore()
    
    var event: Event! {
        didSet {
            thumbnailView.image = UIImage(named: event.imageName)
            eventView.thumbnailView.image = UIImage(named: event.imageName)
            eventView.titleLabel.text = event.title
            eventView.dateLabel.text = event.date.asString()
            attributionLabel.text = "photo by \(event.imageAuthor) via unsplash.com"
        }
    }
    
    let backgroundEffectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView()
        effectView.translatesAutoresizingMaskIntoConstraints = false
        let blurEffect = UIBlurEffect(style: .regular)
        effectView.effect = blurEffect
        effectView.isHidden = true
        effectView.alpha = 0
        
        return effectView
    }()
    
    let addReminderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Themes.currentTheme.secondaryAccentColor
        button.layer.cornerRadius = 17
        button.setTitleColor(Themes.currentTheme.primaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitle("Set Reminder", for: .normal)
        button.addTarget(self, action: #selector(addEvent), for: .touchUpInside)
        button.alpha = 0
        
        return button
    }()
    
    let doneTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = Themes.currentTheme.tertiaryAccentColor
        label.text = "Done!"
        label.alpha = 0
        
        return label
    }()
    
    let goBackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = #imageLiteral(resourceName: "back-icon").withRenderingMode(.alwaysTemplate)
        button.imageView?.tintColor = UIColor.white
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
    
    let attributionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.alpha = 0
        
        return label
    }()
    
    let eventView: BaseEventView = {
        let eventView = BaseEventView()
        eventView.translatesAutoresizingMaskIntoConstraints = false
        eventView.backgroundColor = Themes.currentTheme.primaryColor
        
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
        label.textColor = Themes.currentTheme.primaryFontColor
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

    var eventViewTopConstraint: NSLayoutConstraint!
    var thumbnailTopConstraint: NSLayoutConstraint!
    var thumbnailHeightConstraint: NSLayoutConstraint!
    var reminderButtonTopConstraint: NSLayoutConstraint!
    var reminderButtonBottomConstraint: NSLayoutConstraint!
    var doneTextLabelCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Themes.currentTheme.primaryColor
        setupLayout()
        setupActivityIndicatorLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goBackButton.fadeIn(duration: 0.1)
        addReminderButton.fadeIn(duration: 0.5)
        getData()
    }
    
    private func setupLayout () {
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
        
        
        thumbnailView.addSubview(attributionLabel)
        attributionLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        attributionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        attributionLabel.topAnchor.constraint(equalTo: thumbnailView.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        
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
        
        
        view.addSubview(backgroundEffectView)
        backgroundEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        view.addSubview(doneTextLabel)
        doneTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneTextLabelCenterYConstraint = doneTextLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        doneTextLabelCenterYConstraint.isActive = true
    }
    
    private func setupActivityIndicatorLayout() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: detailLabel.centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func getData() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
            self?.detailLabel.text = self?.event.details
            self?.attributionLabel.fadeIn(duration: 0.5)
            self?.detailLabel.fadeIn(duration: 1)
        }
    }

    @objc private func addEvent() {
        askToAddEvent()
    }
    
    private func askToAddEvent() {
        backgroundEffectView.alpha = 0
        backgroundEffectView.isHidden = false
        backgroundEffectView.fadeIn(duration: 2)
        let eventText = "\(event.title), \(event.date.asString()), (1 hour)"
        
        var alert = UIAlertController(title: "Add event to calendar?", message: eventText, preferredStyle: .actionSheet)
        if UIDevice.current.userInterfaceIdiom == .pad {
            alert = UIAlertController(title: "Add event to calendar?", message: eventText, preferredStyle: .alert)
        }

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            self.createEventinTheCalendar(title: self.event.title, date: self.event.date)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {(action) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.backgroundEffectView.alpha = 0
            }, completion: { (_) in
                self.backgroundEffectView.isHidden = false
            })
        }))
        self.present(alert, animated: true)
    }
    
    private func createEventinTheCalendar(title: String, date :Date) {
        store.requestAccess(to: .event) { (success, error) in
            guard error == nil else { return }
            
            let event = EKEvent.init(eventStore: self.store)
            event.calendar = self.store.defaultCalendarForNewEvents
            event.title = title
            event.startDate = date
            event.endDate = date.addingTimeInterval(1 * 60 * 60)
            
            do {
                try self.store.save(event, span: .thisEvent)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.animatedoneTextLabel()
            }
        }
    }
    
    private func animatedoneTextLabel() {
        doneTextLabelCenterYConstraint.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.view.layoutIfNeeded()
            self?.doneTextLabel.alpha = 1
        }) { (_) in
            self.doneTextLabelCenterYConstraint.constant = -50
            UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseInOut, animations: { [weak self] in
                self?.view.layoutIfNeeded()
                self?.doneTextLabel.alpha = 0
                self?.backgroundEffectView.alpha = 0
                }, completion: { (_) in
                    self.doneTextLabelCenterYConstraint.constant = 50
                    self.backgroundEffectView.isHidden = true
                    self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc private func goBack() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        thumbnailView.alpha = 0
        goBackButton.fadeOut(duration: 0.1)
        attributionLabel.fadeOut(duration: 0.5)
        detailLabel.fadeOut(duration: 0.3)
        addReminderButton.fadeOut(duration: 0.2)
        eventView.setOriginalConstraints()

        eventViewTopConstraint.constant = animationOffset
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseInOut, animations: { [weak self] in
            self?.view.layoutIfNeeded()
            self?.view.backgroundColor = Themes.currentTheme.secondaryColor
        }) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
}
