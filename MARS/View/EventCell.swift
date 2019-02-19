//
//  EventCell.swift
//  MARS
//
//  Created by Mac on 2/17/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    
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
        label.textColor = primaryFontColor
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = secondaryFontColor
        
        return label
    }()
    
    var leadingThumbnailConstraint: NSLayoutConstraint!
    var trailingThumbnailConstraint: NSLayoutConstraint!
    var heightThumbnailConstraint: NSLayoutConstraint!
    var dateLabelLeadingConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = secondaryColor
        layer.cornerRadius = 15
        layer.masksToBounds = true

        addSubview(thumbnailView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        
        thumbnailView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        heightThumbnailConstraint = thumbnailView.heightAnchor.constraint(equalToConstant: 220)
        leadingThumbnailConstraint = thumbnailView.leadingAnchor.constraint(equalTo: leadingAnchor)
        trailingThumbnailConstraint = thumbnailView.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        leadingThumbnailConstraint.isActive = true
        trailingThumbnailConstraint.isActive = true
        heightThumbnailConstraint.isActive = true
        
//        thumbnailView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 9/14).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        dateLabelLeadingConstraint = dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        dateLabelLeadingConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
