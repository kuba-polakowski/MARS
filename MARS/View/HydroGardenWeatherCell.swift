//
//  HydroGardenWeatherCell.swift
//  MARS
//
//  Created by Mac on 2/25/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class HydroGardenWeatherCell: UICollectionViewCell {
    
    var colors: [CGColor]! {
        didSet {
            gradient.colors = [colors[0], colors[1]]
        }
    }
    
    let gradient = CAGradientLayer()
    
    let background: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let effectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView()
        effectView.translatesAutoresizingMaskIntoConstraints = false
        let effect = UIBlurEffect(style: .light)
        effectView.effect = effect
        
        return effectView
    }()
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = primaryColor
        imageView.alpha = 0
        
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = primaryColor
        label.alpha = 0
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(background)
        background.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        background.topAnchor.constraint(equalTo: topAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        background.layer.addSublayer(gradient)
        
        addSubview(effectView)
        effectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        effectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        effectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        effectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        addSubview(label)
        label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20)
        label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        
        addSubview(icon)
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 100).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 100).isActive = true

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = background.frame
        gradient.startPoint = CGPoint(x: 0.2, y: 0.2)
        gradient.endPoint = CGPoint(x: 0.3, y: 1)

        label.fadeIn(duration: 1.5)
        icon.fadeIn(duration: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
