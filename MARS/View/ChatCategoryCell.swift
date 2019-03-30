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
    
    let fadeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, currentTheme.primaryColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.9, y: -0.2)
        gradientLayer.endPoint = CGPoint(x: 0.6, y: 1.1)
        
        return gradientLayer
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        cellShapeView.addSubview(categoryImageView)
        categoryImageView.leadingAnchor.constraint(equalTo: cellShapeView.leadingAnchor).isActive = true
        categoryImageView.topAnchor.constraint(equalTo: cellShapeView.topAnchor).isActive = true
        categoryImageView.trailingAnchor.constraint(equalTo: cellShapeView.trailingAnchor).isActive = true
        categoryImageView.bottomAnchor.constraint(equalTo: cellShapeView.bottomAnchor).isActive = true
        
        cellShapeView.addSubview(fadeView)
        fadeView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fadeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fadeView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        fadeView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        fadeView.layer.addSublayer(gradientLayer)

        label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        cellShapeView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        cellShapeView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        cellShapeView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        cellShapeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        label.textColor = currentTheme.secondaryFontColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradient()
    }
    
    private func setupGradient() {
        gradientLayer.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
