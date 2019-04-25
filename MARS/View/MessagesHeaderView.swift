//
//  MessagesHeaderView.swift
//  MARS
//
//  Created by Mac on 2/18/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class paddedLabel: UILabel {
    
    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        let newWidth = originalSize.width + 12
        let newHeight = originalSize.height + 10
        
        return CGSize(width: newWidth, height: newHeight)
    }
    
}

class MessagesHeaderView: UIView {

    let label: paddedLabel = {
        let label = paddedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Themes.currentTheme.primaryColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.backgroundColor = Themes.currentTheme.secondaryAccentColor
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
