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
    
    var activity: Activity! {
        didSet {
            imageView.image = UIImage(named: activity.name.lowercased())
            titleLabel.text = activity.name
        }
    }
    
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = Themes.currentTheme.primaryFontColor
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 4
        label.textColor = Themes.currentTheme.secondaryFontColor
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Themes.currentTheme.primaryColor
        layer.cornerRadius = 15
        layer.masksToBounds = true
        addSubview(imageView)
        addSubview(titleLabel)
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isCellBig {
            addSubview(detailLabel)
        } else {
            detailLabel.removeFromSuperview()
        }
        setupLayoutBasedOnSize()
    }
    
    private func setupLayout() {
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 25).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupLayoutBasedOnSize() {
        titleLabel.textAlignment = isCellBig ? .left : .center
        titleLabel.font = isCellBig ? UIFont.systemFont(ofSize: 25, weight: .semibold) : UIFont.systemFont(ofSize: 22, weight: .semibold)
        if isCellBig {
            detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
            detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
