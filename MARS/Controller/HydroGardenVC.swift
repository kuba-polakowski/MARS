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
        
        collectionView.backgroundColor = primaryColor
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isPagingEnabled = true
        
        collectionView.register(HydroGardenWeatherCell.self, forCellWithReuseIdentifier: hydroGardenCellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: .curveEaseInOut, animations: { [weak self] in
            self?.collectionView.contentOffset.x = 50
        })  { (_) in
            self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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
        
        cell.weather = weather
        cell.temperatureLabel.text = "\(weather.temperature)"
        cell.weatherDescriptionLabel.text = weather.weatherDescription()
        
        if let image = UIImage(named: "weather-\(iconNames[indexPath.item])") {
            cell.weatherIconImageView.image = image.withRenderingMode(.alwaysTemplate)
        }

        return cell
    }
    
    
}
