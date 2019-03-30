//
//  ActivityCell.swift
//  MARS
//
//  Created by Mac on 3/12/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class ActivityCell: UICollectionViewCell {
    
    var isCellBig: Bool!
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = currentTheme.primaryFontColor
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textColor = currentTheme.secondaryFontColor
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = currentTheme.primaryColor
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        setupLayoutBasedOnSize()
    }
    
    private func setupLayout() {
        addSubview(imageView)
        addSubview(titleLabel)

        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 25).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupLayoutBasedOnSize() {
        titleLabel.textAlignment = isCellBig ? .left : .center
        if isCellBig {
            addSubview(detailLabel)
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
            detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        } else {
            detailLabel.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
