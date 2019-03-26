//
//  LSCircleView.swift
//  MARS
//
//  Created by Mac on 2/22/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class LSStatCell: UICollectionViewCell {
    
    let circleLayer = CAShapeLayer()
    let shadowLayer = CAShapeLayer()
    
    var color: UIColor!
    var value: CGFloat!
    
    var delay: Double!
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = currentTheme.primaryFontColor
        label.adjustsFontSizeToFitWidth = true
        label.alpha = 0
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = currentTheme.secondaryFontColor
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 40).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true

        addSubview(percentageLabel)
        percentageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        percentageLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        percentageLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addCircle()
    }
    
    func animateCircle(after delay: Double, toValue: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = toValue
        animation.duration = 2
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 + delay) { [weak self] in
            self?.circleLayer.add(animation, forKey: "animateValue")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 + delay) { [weak self] in
            self?.percentageLabel.fadeIn(duration: 1)
        }
    }
    
    func addCircle() {
        let radius = frame.width / 2
        let path = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shadowLayer.path = path.cgPath
        
        layer.addSublayer(shadowLayer)
        shadowLayer.lineWidth = 10
        shadowLayer.strokeColor = UIColor.gray.cgColor
        shadowLayer.lineCap = .round
        shadowLayer.fillColor = UIColor.clear.cgColor
        
        
        circleLayer.path = path.cgPath
        
        layer.addSublayer(circleLayer)
        circleLayer.lineWidth = 10
        circleLayer.strokeEnd = 0
        circleLayer.lineCap = .round
        circleLayer.fillColor = UIColor.clear.cgColor
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
