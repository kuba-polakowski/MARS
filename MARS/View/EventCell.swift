//
//  EventCell.swift
//  MARS
//
//  Created by Mac on 2/17/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    
    let eventView: BaseEventView = {
        let eventView = BaseEventView()
        eventView.translatesAutoresizingMaskIntoConstraints = false
        
        return eventView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(eventView)
        eventView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        eventView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        eventView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        eventView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    func animateForTransition(withInsets: UIEdgeInsets) {
        eventView.animateForTransition(withInsets: withInsets)
    }
    
    func setOriginalConstraints() {
        eventView.setOriginalConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
