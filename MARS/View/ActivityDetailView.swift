//
//  ActivityDetailView.swift
//  MARS
//
//  Created by Mac on 3/17/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class ActivityDetailView: UIView {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = primaryColor
        
        return view
    }()
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "macaw")
        
        return imageView
    }()
    
    let exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = #imageLiteral(resourceName: "exit-icon").withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = primaryColor
        button.addTarget(self, action: #selector(collapseAndDismiss), for: .touchUpInside)
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = primaryFontColor
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.text = upcomingEvents.first?.title
        
        return label
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = tertiaryRedColor
        
        return view
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = secondaryFontColor
        label.numberOfLines = 0
        label.text = upcomingEvents.first?.details
        label.backgroundColor = primaryColor
        
        return label
    }()

    let bottomFadeGradientView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        (view.layer as! CAGradientLayer).locations = [0.0, 0.05, 0.95, 1.0]
        (view.layer as! CAGradientLayer).colors = [primaryColor.cgColor, primaryColor.withAlphaComponent(0.01).cgColor, primaryColor.withAlphaComponent(0.01).cgColor, primaryColor.cgColor]
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        
        setupViews()
        setupLayout()
        setupSwipeDownGestureRecognizer()
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(thumbnailImageView)
        thumbnailImageView.addSubview(exitButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(separatorLine)
        containerView.addSubview(scrollView)
        scrollView.addSubview(detailLabel)
        scrollView.addSubview(bottomFadeGradientView)
    }
    
    var containerTopConstraint: NSLayoutConstraint!
    var containerBottomConstraint: NSLayoutConstraint!
    
    private func setupLayout() {
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        containerTopConstraint = containerView.topAnchor.constraint(equalTo: topAnchor)
        containerTopConstraint.isActive = true
        
        containerBottomConstraint = containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        containerBottomConstraint.isActive = true
        
        thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        exitButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        separatorLine.centerYAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        detailLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
        
        bottomFadeGradientView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomFadeGradientView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor).isActive = true
        bottomFadeGradientView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomFadeGradientView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupSwipeDownGestureRecognizer() {
        let swipeDownToCollapse = UISwipeGestureRecognizer(target: self, action: #selector(collapseAndDismiss))
        swipeDownToCollapse.direction = .down
        thumbnailImageView.addGestureRecognizer(swipeDownToCollapse)
        thumbnailImageView.isUserInteractionEnabled = true
    }
    
    @objc private func collapseAndDismiss() {
        
        containerTopConstraint.constant = bounds.height / 2
        containerBottomConstraint.constant = -bounds.height / 2

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            self.layoutIfNeeded()
            self.layer.shadowOpacity = 0.8
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [unowned self] in
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
