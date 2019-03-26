//
//  TransitVC.swift
//  MARS
//
//  Created by Mac on 2/23/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit
import MapKit

class TransitVC: UIViewController {
    
    var vehiclesAvailable = vehicles
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
//        mapView.
        let location = CLLocation(latitude: 21.30, longitude: -157.85)
        let regionRadius: CLLocationDistance = 10000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        let vehicleLocationAnnotation = MKPointAnnotation()
        
        return mapView
    }()
    
    let menuView: TransitMenuView = {
        let menuView = TransitMenuView()
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        return menuView
    }()
    
    var menuTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Transit"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let navigationController = navigationController, navigationController.navigationBar.isHidden {
            navigationController.navigationBar.alpha = 0
            navigationController.navigationBar.isHidden = false
            UIView.animate(withDuration: 1) {
                navigationController.navigationBar.alpha = 1
            }
        }
        
        view.addSubview(mapView)
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -105).isActive = true
        
        setupVehiclesOnMap()
        
        setupMenuView()
        addSwipeMenuGestureRecognizers()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        menuView.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setupVehiclesOnMap() {
        var vehiclesMapAnnotations = [MKPointAnnotation]()
        for vehicle in vehiclesAvailable {
            if vehicle.charge > 0 {
                let annotation = MKPointAnnotation()
                annotation.coordinate = vehicle.location
                annotation.title = vehicle.name
                annotation.subtitle = "\(vehicle.charge)% charge"
                vehiclesMapAnnotations.append(annotation)
            }
        }
        mapView.addAnnotations(vehiclesMapAnnotations)
    }
    
    private func addSwipeMenuGestureRecognizers() {
        let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(expandMenu))
        swipeUpRecognizer.direction = .up
        menuView.addGestureRecognizer(swipeUpRecognizer)

        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(collapseMenu))
        swipeDownRecognizer.direction = .down
        menuView.addGestureRecognizer(swipeDownRecognizer)
        
        let touchMapRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchedMap))
        mapView.addGestureRecognizer(touchMapRecognizer)
    }
    
    @objc private func touchedMap() {
    }

    @objc private func expandMenu() {
        guard menuTopConstraint.constant == -155 else { return }
        menuTopConstraint.constant = -350
        menuView.isExpanded = true
        animateMenu()
    }
    
    @objc private func collapseMenu() {
        guard menuTopConstraint.constant == -350 else { return }
        menuTopConstraint.constant = -155
        menuView.isExpanded = false
        animateMenu()
    }
    
    @objc func expandButtonPressed() {
        if menuTopConstraint.constant == -155 {
            expandMenu()
        } else {
            collapseMenu()
        }
    }
    
    @objc func summonVehicle() {
        print("calling the vehicle...")
    }
    
    func animateMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            self.view.layoutIfNeeded()
            self.menuView.collectionView.reloadData()
        })
    }
    
    private func setupMenuView() {
        view.addSubview(menuView)
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuTopConstraint = menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -155)
        menuTopConstraint.isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.isExpanded = false
        
        menuView.expandButton.addTarget(self, action: #selector(expandButtonPressed), for: .touchUpInside)
        menuView.summonVehicleButton.addTarget(self, action: #selector(summonVehicle), for: .touchUpInside)
    }

}
