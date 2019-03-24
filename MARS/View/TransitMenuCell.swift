//
//  TransitMenuCell.swift
//  MARS
//
//  Created by Mac on 2/23/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class TransitMenuCell: UICollectionViewCell {
    
    var available: Bool! {
        didSet {
            setColors()
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = tertiaryFontColor
        
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = primaryFontColor
        
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = primaryFontColor
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            guard available else { return }
            imageView.tintColor = isSelected ? primaryRedColor : tertiaryFontColor
            label.textColor = isSelected ? primaryRedColor : primaryFontColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        layer.cornerRadius = 10
        
        addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        imageView.widthAnchor.constraint(equalTo: heightAnchor, constant: -30).isActive = true
        
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(countLabel)
        countLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        countLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setColors() {
        if available {
            backgroundColor = .clear
            imageView.tintColor = secondaryFontColor
            label.textColor = primaryFontColor
        } else {
            backgroundColor = secondaryColor
            imageView.tintColor = primaryColor
            label.textColor = secondaryColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
