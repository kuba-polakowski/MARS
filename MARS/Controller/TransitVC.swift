//
//  TransitVC.swift
//  MARS
//
//  Created by Mac on 2/23/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit
import MapKit

private let menuButtonHeight: CGFloat = 50
private let collapsedMenuHeight: CGFloat = 100
private let expandedMenuHeight: CGFloat = 350

class TransitVC: UIViewController {
    
    var vehiclesAvailable = vehicles
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        setupNavigationBar()
        setupLayout()
        setupMenuView()

        setupVehiclesOnMap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        zoomOutMap()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        menuView.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Transit"
        if let navigationController = navigationController, navigationController.navigationBar.isHidden {
            navigationController.navigationBar.alpha = 0
            navigationController.navigationBar.isHidden = false
            UIView.animate(withDuration: 1) {
                navigationController.navigationBar.alpha = 1
            }
        }
    }
    
    private func setupLayout() {
        view.addSubview(mapView)
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collapsedMenuHeight).isActive = true
        
        view.addSubview(menuView)
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuTopConstraint = menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collapsedMenuHeight - menuButtonHeight)
        menuTopConstraint.isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.isExpanded = false
    }
    
    private func setupMenuView() {
        menuView.expandButton.addTarget(self, action: #selector(expandButtonPressed), for: .touchUpInside)
        menuView.summonVehicleButton.addTarget(self, action: #selector(summonVehicle), for: .touchUpInside)
        
        addSwipeMenuGestureRecognizers()
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
    }
    
    @objc private func expandMenu() {
        guard menuTopConstraint.constant == -collapsedMenuHeight - menuButtonHeight else { return }
        menuTopConstraint.constant = -expandedMenuHeight
        menuView.isExpanded = true
        animateMenu()
    }
    
    @objc private func collapseMenu() {
        guard menuTopConstraint.constant == -expandedMenuHeight else { return }
        menuTopConstraint.constant = -collapsedMenuHeight - menuButtonHeight
        menuView.isExpanded = false
        animateMenu()
    }
    
    @objc func expandButtonPressed() {
        if menuTopConstraint.constant == -collapsedMenuHeight - menuButtonHeight {
            expandMenu()
        } else {
            collapseMenu()
        }
    }
    
    @objc func summonVehicle() {
        if let chosenVehicle = menuView.chosenVehicle {
            showVehicleAlert(for: chosenVehicle)
            showOnMap(center: chosenVehicle.location, around: CLLocationDistance(100))
        }
    }
    
    private func showVehicleAlert(for vehicle: Vehicle) {
        let vehicleCallDetails = "\(vehicle.name), \(vehicle.charge)% charged, 15 minutes away"
        let alert = UIAlertController(title: "Call vehicle?", message: vehicleCallDetails, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            print("DONE")
        }))
        
        alert.addAction(UIAlertAction(title: "Nah", style: .cancel, handler: { (action) in
            self.zoomOutMap()
        }))
        self.present(alert, animated: true)
    }
    
    private func showOnMap(center location: CLLocationCoordinate2D, around radius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: radius, longitudinalMeters: radius)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func zoomOutMap() {
        let location = CLLocation(latitude: 21.30, longitude: -157.85)
        let radius: CLLocationDistance = 10000
        showOnMap(center: location.coordinate, around: radius)
    }
    
    private func animateMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            self.view.layoutIfNeeded()
            self.menuView.collectionView.reloadData()
        })
    }
    

}
