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
        imageView.image = #imageLiteral(resourceName: "menuHeader")
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
