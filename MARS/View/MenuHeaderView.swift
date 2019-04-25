//
//  MenuHeaderView.swift
//  MARS
//
//  Created by Mac on 2/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class MenuHeaderView: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let attributionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        label.numberOfLines = 3
        label.textAlignment = .right
        label.text = "Photo by Daniel Olah via unsplash.com\nAll icons made by Gregor Cresnar and Freepik\nfrom www.flaticon.com"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: frame.height * 2).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(attributionLabel)
        attributionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        attributionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        attributionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
