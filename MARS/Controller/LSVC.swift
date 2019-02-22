//
//  LSVC.swift
//  MARS
//
//  Created by Mac on 2/22/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class LSVC: UIViewController {
    
    var circleLayers = [CAShapeLayer]()
    var shadowLayers = [CAShapeLayer]()
    
    let labels: [UILabel] = {
        var labels = [UILabel]()
        for category in lSCategories {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
            label.textColor = primaryFontColor
            label.adjustsFontSizeToFitWidth = true
            
            labels.append(label)
        }
        return labels
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addCircles()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateCircles()
    }
    
    func animateCircles() {
        for i in 0...lSCategories.count - 1 {
            let delay: Double = Double(i) * 0.2
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [unowned self] in
                self.animateCircle(layer: self.circleLayers[i], toValue: lSCategories[i].value - 0.2)
            }
        }
    }
    
    func addCircles() {
        for i in 1...lSCategories.count {
            guard i <= 6 else { return }
            let category = lSCategories[i - 1]
            
            let label = labels[i - 1]
            view.addSubview(label)
            label.text = category.title
            
            let xPoint: CGFloat = {
                if i == 5 {
                    return view.center.x
                } else {
                    return i % 2 == 1 ? view.center.x * 0.5 : view.center.x * 1.5
                }
            }()
            
            
            let yPoint: CGFloat = {
                if i < 3 {
                    return view.center.y * 0.5
                } else if i < 5 {
                    return view.center.y
                } else {
                    return view.center.y * 1.5
                }
            }()
            
            let center = CGPoint(x: xPoint, y: yPoint)
            addCircle(at: center, color: category.color)
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: xPoint).isActive = true
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: yPoint).isActive = true
            label.widthAnchor.constraint(equalToConstant: 130).isActive = true
        }
    }
    
    func animateCircle(layer: CALayer, toValue: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = toValue
        animation.duration = 3
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        layer.add(animation, forKey: "animateValue")
    }
    
    func addCircle(at point: CGPoint, color: UIColor) {
        
        let circleLayer = CAShapeLayer()
        circleLayers.append(circleLayer)
        
        let shadowLayer = CAShapeLayer()
        shadowLayers.append(shadowLayer)
        
        let path = UIBezierPath(arcCenter: point, radius: 90, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shadowLayer.path = path.cgPath
        
        view.layer.addSublayer(shadowLayer)
        shadowLayer.lineWidth = 10
        shadowLayer.strokeColor = secondaryColor.cgColor
        shadowLayer.lineCap = .round
        shadowLayer.fillColor = UIColor.clear.cgColor
        
        
        circleLayer.path = path.cgPath
        
        view.layer.addSublayer(circleLayer)
        circleLayer.lineWidth = 10
        circleLayer.strokeColor = color.cgColor
        circleLayer.strokeEnd = 0
        circleLayer.lineCap = .round
        circleLayer.fillColor = UIColor.clear.cgColor
    }
    
}
