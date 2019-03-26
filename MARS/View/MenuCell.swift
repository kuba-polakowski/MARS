//
//  MenuCell.swift
//  MARS
//
//  Created by Mac on 2/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    var category: Category!
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = currentTheme.primaryColor
        label.textColor = currentTheme.primaryFontColor
        imageView.tintColor = currentTheme.primaryAccentColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
