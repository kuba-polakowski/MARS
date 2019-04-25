//
//  MessageCell.swift
//  MARS
//
//  Created by Mac on 2/13/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    var isIncoming: Bool! {
        didSet {
            cellShapeView.backgroundColor = isIncoming ? Themes.currentTheme.secondaryColor : Themes.currentTheme.primaryAccentColor
            messageTextLabel.textColor = isIncoming ? Themes.currentTheme.primaryFontColor : Themes.currentTheme.primaryColor
            if isIncoming {
                NSLayoutConstraint.deactivate(trailingConstraints)
                NSLayoutConstraint.activate(leadingConstraints)
            } else {
                NSLayoutConstraint.deactivate(leadingConstraints)
                NSLayoutConstraint.activate(trailingConstraints)
            }
        }
    }
    
    var isContinuing: Bool! {
        didSet {
            authorLabelHeightConstraint.constant = isContinuing ? 0 : 20
            topPaddingConstraint.constant = isContinuing ? 20 : 40
        }
    }
    
    let cellShapeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15

        return view
    }()
    
    let messageTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Themes.currentTheme.primaryFontColor
        
        return label
    }()
    
    var leadingConstraints: [NSLayoutConstraint] = []
    var trailingConstraints: [NSLayoutConstraint] = []
    
    var authorLabelHeightConstraint: NSLayoutConstraint!
    var topPaddingConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = Themes.currentTheme.primaryColor
        
        
        addSubview(authorLabel)
        authorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        authorLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
        
        authorLabelHeightConstraint = authorLabel.heightAnchor.constraint(equalToConstant: 0)

        
        addSubview(cellShapeView)
        addSubview(messageTextLabel)

        cellShapeView.leadingAnchor.constraint(equalTo: messageTextLabel.leadingAnchor, constant: -10).isActive = true
        cellShapeView.topAnchor.constraint(equalTo: messageTextLabel.topAnchor, constant: -10).isActive = true
        cellShapeView.trailingAnchor.constraint(equalTo: messageTextLabel.trailingAnchor, constant: 10).isActive = true
        cellShapeView.bottomAnchor.constraint(equalTo: messageTextLabel.bottomAnchor, constant: 10).isActive = true
        
        
        messageTextLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.75).isActive = true
        messageTextLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true

        bottomConstraint = messageTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        bottomConstraint.priority = .defaultLow
        bottomConstraint.isActive = true
        
        topPaddingConstraint = messageTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        authorLabelHeightConstraint.isActive = true
        topPaddingConstraint.isActive = true
        
        leadingConstraints.append(messageTextLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20))
        
        trailingConstraints.append(messageTextLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
