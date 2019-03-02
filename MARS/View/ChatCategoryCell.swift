//
//  ChatCell.swift
//  MARS
//
//  Created by Mac on 2/12/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class ChatCategoryCell: BaseTableViewCell {

    let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellShapeView.addSubview(categoryImageView)
        categoryImageView.leadingAnchor.constraint(equalTo: cellShapeView.leadingAnchor).isActive = true
        categoryImageView.topAnchor.constraint(equalTo: cellShapeView.topAnchor).isActive = true
        categoryImageView.trailingAnchor.constraint(equalTo: cellShapeView.trailingAnchor).isActive = true
        categoryImageView.bottomAnchor.constraint(equalTo: cellShapeView.bottomAnchor).isActive = true
        label.textColor = primaryColor

        label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        cellShapeView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        cellShapeView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        cellShapeView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        cellShapeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
    }    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
