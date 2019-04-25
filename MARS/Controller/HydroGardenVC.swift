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
    
    var currentWeather = [GardenName:Weather]()
    
    let iconNames = ["clouds", "sun", "rain", "snow"]
    
    var temperatureScale: TemperatureScale = {
        if UserDefaults.standard.currentTemperatureScaleIsCelsius() {
            return .celsius
        } else {
            return .farenheit
        }
    }()

    let temperatureScaleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("temp scale", for: .normal)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 14
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        button.addTarget(self, action: #selector(changeTemperatureScale), for: .touchUpInside)
        button.alpha = 0
        
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.isHidden = true
        activityIndicatorView.color = .white
        
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupCollectionView()
        setupLayout()
        setupActivityIndicatorLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
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
    
    private func setupNavigationController() {
        if let navigationController = navigationController, navigationController.navigationBar.isHidden {
            navigationController.navigationBar.alpha = 0
            navigationController.navigationBar.isHidden = false
            UIView.animate(withDuration: 1) {
                navigationController.navigationBar.alpha = 1
            }
        }
        navigationItem.title = "Hydroponic Gardens"
    }
    
    private func setupCollectionView() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        collectionView.backgroundColor = Themes.currentTheme.primaryColor
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isPagingEnabled = true
        
        collectionView.register(HydroGardenWeatherCell.self, forCellWithReuseIdentifier: hydroGardenCellId)
    }
    
    private func setupLayout() {
        view.addSubview(temperatureScaleButton)
        temperatureScaleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        temperatureScaleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        temperatureScaleButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        temperatureScaleButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    private func setupActivityIndicatorLayout() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func getData() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
            for garden in Gardens.all {
                for weather in WeatherSituations.current {
                    if weather.gardenName == garden.name {
                        self?.currentWeather[garden.name] = weather
                    }
                }
            }
            self?.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.frame.size
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Gardens.all.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hydroGardenCellId, for: indexPath) as! HydroGardenWeatherCell
        let garden = Gardens.all[indexPath.item]
        cell.colors = garden.colors

        var name = ""
        switch garden.name {
        case .temperate:
            name = "Temperate Garden"
        case .drought:
            name = "Drought Garden"
        case .tropical:
            name = "Tropical Garden"
        case .snowy:
            name = "Snow Garden"
        }
        cell.gardenNameLabel.text = name
        
        if let image = UIImage(named: "weather-\(iconNames[indexPath.item])") {
            cell.weatherIconImageView.image = image.withRenderingMode(.alwaysTemplate)
        }
        
        if let weather = currentWeather[garden.name] {
            cell.precipitationView.addEmitterCells(for: weather)
            
            let temperature = temperatureScale == .celsius ? weather.temperature : weather.tempInFarenheit()
            let temperatureSymbol = getTemperatureSymbol()
            cell.temperatureLabel.text = "\(temperature)\(temperatureSymbol)"
            cell.weatherDescriptionLabel.text = weather.weatherDescription()
        }

        return cell
    }
    
    @objc private func changeTemperatureScale() {
        let scaleIsSetToCelsius = temperatureScale == .celsius
        UserDefaults.standard.setTemperatureScaleToCelsius(!scaleIsSetToCelsius)
        temperatureScale = UserDefaults.standard.currentTemperatureScaleIsCelsius() ? .celsius : .farenheit

        collectionView.reloadData()
    }
    
    private func getTemperatureSymbol() -> String {
        var symbol = ""
        switch temperatureScale {
        case .celsius:
            symbol =  "C"
        case .farenheit:
            symbol =  "F"
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
