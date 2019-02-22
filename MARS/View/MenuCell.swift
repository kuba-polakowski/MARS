//
//  MenuCell.swift
//  MARS
//
//  Created by Mac on 2/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        label.textColor = primaryFontColor
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = secondaryFontColor
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = secondaryColor
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        
        contentMode = .bottomLeft
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
