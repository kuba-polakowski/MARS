//
//  HydroGardenVC.swift
//  MARS
//
//  Created by Mac on 2/25/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

private let hydroGardenCellId = "hydroGardenCellId"

class HydroGardenVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let iconNames = ["clouds", "sun", "rain", "snow"]
    
    var temperatureScale: TemperatureScale = {
        return UserDefaults.standard.currentTemperatureScale()
    }()

    let temperatureScaleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.addTarget(self, action: #selector(changeTemperatureScale), for: .touchUpInside)
        button.alpha = 0
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController, navigationController.navigationBar.isHidden {
            navigationController.navigationBar.alpha = 0
            navigationController.navigationBar.isHidden = false
            UIView.animate(withDuration: 1) {
                navigationController.navigationBar.alpha = 1
            }
        }
        navigationItem.title = "Hydroponic Gardens"
                
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        collectionView.backgroundColor = currentTheme.primaryColor
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isPagingEnabled = true
        
        collectionView.register(HydroGardenWeatherCell.self, forCellWithReuseIdentifier: hydroGardenCellId)
        
        view.addSubview(temperatureScaleButton)
        temperatureScaleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        temperatureScaleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        temperatureScaleButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        temperatureScaleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        setupButtonTitle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        temperatureScaleButton.fadeIn(duration: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            if self?.collectionView.contentOffset.x == 0 {
                self?.hintNextCollectionViewCell()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.frame.size
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gardens.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hydroGardenCellId, for: indexPath) as! HydroGardenWeatherCell
        let garden = gardens[indexPath.item]
        let weather = weatherSituations[indexPath.item]
        
        cell.gardenNameLabel.text = garden.name
        cell.colors = garden.colors
        
        cell.precipitationView.addEmitterCells(for: weather)

        let temperature = temperatureScale == .celsius ? weather.temperature : weather.tempInFarenheit()
        let temperatureSymbol = getTemperatureSymbol()
        cell.temperatureLabel.text = "\(temperature)\(temperatureSymbol)"
        cell.weatherDescriptionLabel.text = weather.weatherDescription()
        
        if let image = UIImage(named: "weather-\(iconNames[indexPath.item])") {
            cell.weatherIconImageView.image = image.withRenderingMode(.alwaysTemplate)
        }

        return cell
    }
    
    @objc private func changeTemperatureScale() {
        UserDefaults.standard.setTemperatureScaleTo(scale: temperatureScale == .celsius ? .farenheit : .celsius)
        setupButtonTitle()

        view.setNeedsLayout()
    }
    
    private func setupButtonTitle() {
        temperatureScaleButton.setTitle(getTemperatureSymbol(), for: .normal)
    }
    
    private func getTemperatureSymbol() -> String {
        var symbol: String {
            switch temperatureScale {
            case .celsius:
                return "C"
            case .farenheit:
                return "F"
            }
        }
        return "°" + symbol
    }
    
    private func hintNextCollectionViewCell() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.collectionView.contentOffset.x = 50
            }, completion: { (_) in
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 3, options: .curveEaseInOut, animations: { [weak self] in
                    self?.collectionView.contentOffset.x = 1
                    }, completion: { (_) in
                        self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                })
        })
    }
    
}
