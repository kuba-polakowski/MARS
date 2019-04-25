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
            (backgroundGradientView.layer as! CAGradientLayer).colors = [colors[0], colors[1]]
        }
    }
        
    let precipitationView: ParticleView = {
        let particleView = ParticleView()
        particleView.translatesAutoresizingMaskIntoConstraints = false
        particleView.image = UIImage(named: "weather-dot")
        particleView.color = UIColor.blue.cgColor
        particleView.clipsToBounds = true
        
        return particleView
    }()
    
    let backgroundGradientView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        (view.layer as! CAGradientLayer).startPoint = CGPoint(x: 0.2, y: 0.2)
        (view.layer as! CAGradientLayer).endPoint = CGPoint(x: 0.3, y: 1)
        
        return view
    }()
    
    let effectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView()
        effectView.translatesAutoresizingMaskIntoConstraints = false
        let effectStyle = Themes.currentTheme.isLight ? UIBlurEffect.Style.prominent : .dark
        let effect = UIBlurEffect(style: effectStyle)
        effectView.effect = effect
        effectView.alpha = 0.3
        
        return effectView
    }()
    
    let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.white
        imageView.alpha = 0
        
        return imageView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 45)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.white
        label.alpha = 0
        
        return label
    }()

    let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.white
        label.alpha = 0
        
        return label
    }()

    let gardenNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.white
        label.alpha = 0
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroundGradientView)
        backgroundGradientView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundGradientView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundGradientView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundGradientView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(precipitationView)
        precipitationView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        precipitationView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        precipitationView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        precipitationView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        addSubview(effectView)
        effectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        effectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        effectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        effectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        addSubview(gardenNameLabel)
        gardenNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        gardenNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        gardenNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        addSubview(weatherIconImageView)
        weatherIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weatherIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        weatherIconImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        weatherIconImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        addSubview(temperatureLabel)
        temperatureLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor, constant: 50).isActive = true

        addSubview(weatherDescriptionLabel)
        weatherDescriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        weatherDescriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        weatherDescriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 30).isActive = true
        weatherDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true

        gardenNameLabel.fadeIn(duration: 1.5)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let emitterLayer = precipitationView.layer as! CAEmitterLayer
        if temperatureLabel.alpha == 0, weatherDescriptionLabel.alpha == 0, temperatureLabel.text != nil, weatherDescriptionLabel.text != nil {
            weatherIconImageView.fadeIn(duration: 1)
            temperatureLabel.fadeIn(duration: 1.2)
            weatherDescriptionLabel.fadeIn(duration: 1.3)
        }
        
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitterLayer.emitterSize = CGSize(width: 2.5 * bounds.size.width, height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
