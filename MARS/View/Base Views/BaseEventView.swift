//
//  BaseEventView.swift
//  MARS
//
//  Created by Mac on 2/19/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class BaseEventView: UIView {
    
    let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = Themes.currentTheme.primaryFontColor
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Themes.currentTheme.secondaryFontColor
        
        return label
    }()
    
    var topThumbnailConstraint: NSLayoutConstraint!
    var leadingThumbnailConstraint: NSLayoutConstraint!
    var trailingThumbnailConstraint: NSLayoutConstraint!
    var heightThumbnailConstraint: NSLayoutConstraint!
    var dateLabelLeadingConstraint: NSLayoutConstraint!
    var dateLabelTrailingConstraint: NSLayoutConstraint!
    var titleLabelLeadingConstraint: NSLayoutConstraint!
    var titleLabelTopConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Themes.currentTheme.primaryColor
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        addSubview(thumbnailView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        
        topThumbnailConstraint = thumbnailView.topAnchor.constraint(equalTo: topAnchor)
        heightThumbnailConstraint = thumbnailView.heightAnchor.constraint(equalToConstant: 220)
        leadingThumbnailConstraint = thumbnailView.leadingAnchor.constraint(equalTo: leadingAnchor)
        trailingThumbnailConstraint = thumbnailView.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        topThumbnailConstraint.isActive = true
        leadingThumbnailConstraint.isActive = true
        trailingThumbnailConstraint.isActive = true
        heightThumbnailConstraint.isActive = true
        
        titleLabelLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10)
        titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 10)
        titleLabelLeadingConstraint.isActive = true
        titleLabelTopConstraint.isActive = true
        
        titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        dateLabelLeadingConstraint = dateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10)
        dateLabelLeadingConstraint.isActive = true
        
        dateLabelTrailingConstraint = dateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10)
        dateLabelTrailingConstraint.isActive = false
    }
    
    func animateForTransition(withInsets: UIEdgeInsets) {
        clipsToBounds = false
        leadingThumbnailConstraint.constant = -15 - withInsets.left
        trailingThumbnailConstraint.constant = 15 + withInsets.right
        heightThumbnailConstraint.constant = 230
        titleLabelLeadingConstraint.constant = 15
        titleLabelTopConstraint.constant = 15
        dateLabelLeadingConstraint.isActive = false
        dateLabelTrailingConstraint.isActive = true
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.layoutIfNeeded()
        })
    }
    
    func setOriginalConstraints() {
        leadingThumbnailConstraint.constant = 0
        trailingThumbnailConstraint.constant = 0
        heightThumbnailConstraint.constant = 220
        titleLabelLeadingConstraint.constant = 10
        titleLabelTopConstraint.constant = 10
        dateLabelTrailingConstraint.isActive = false
        dateLabelLeadingConstraint.isActive = true
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.layoutIfNeeded()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
