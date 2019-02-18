//
//  MessageCell.swift
//  MARS
//
//  Created by Mac on 2/13/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class MessageCell: BaseTableViewCell {
    
    var isIncoming: Bool! {
        didSet {
            cellShapeView.backgroundColor = isIncoming ? secondaryColor : secondaryRedColor
            label.textColor = isIncoming ? primaryFontColor : primaryColor
            if isIncoming {
                NSLayoutConstraint.activate(leadingConstraints)
            } else {
                NSLayoutConstraint.activate(trailingConstraints)
            }
        }
    }
    
    var isContinuing: Bool! {
        didSet {
            authorLabelHeightConstraint.constant = isContinuing ? 0 : 20
            topPaddingConstraint.constant = isContinuing ? 10 : 40
        }
    }
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = primaryFontColor
        
        return label
    }()
    
    var leadingConstraints: [NSLayoutConstraint] = []
    var trailingConstraints: [NSLayoutConstraint] = []
    
    var authorLabelHeightConstraint: NSLayoutConstraint!
    var topPaddingConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(authorLabel)
        authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        authorLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0

        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true

        label.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.75).isActive = true
        
        cellShapeView.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -10).isActive = true
        cellShapeView.topAnchor.constraint(equalTo: label.topAnchor, constant: -10).isActive = true
        cellShapeView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10).isActive = true
        cellShapeView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        
        authorLabelHeightConstraint = authorLabel.heightAnchor.constraint(equalToConstant: 0)
        topPaddingConstraint = label.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        authorLabelHeightConstraint.isActive = true
        topPaddingConstraint.isActive = true
        
        leadingConstraints.append(label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20))
        
        trailingConstraints.append(label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
