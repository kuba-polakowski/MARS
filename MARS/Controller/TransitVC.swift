//
//  TransitVC.swift
//  MARS
//
//  Created by Mac on 2/23/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit
import MapKit

private var currentFictionalLocation = CLLocationCoordinate2D(latitude: 21.30, longitude: -157.85)

private let menuButtonHeight: CGFloat = 50
private let collapsedMenuHeight: CGFloat = 100
private let expandedMenuHeight: CGFloat = 350

class TransitVC: UIViewController, MKMapViewDelegate {
        
    var vehiclesAvailable = Vehicles.all
    
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
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.isHidden = true
        activityIndicatorView.color = Themes.currentTheme.tertiaryAccentColor
        
        return activityIndicatorView
    }()
    
    var menuTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupLayout()
        setupMenuView()
        setupActivityIndicatorLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        zoomOutMap()
        getData()
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
        
        mapView.delegate = self
        
        view.addSubview(menuView)
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuTopConstraint = menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collapsedMenuHeight - menuButtonHeight)
        menuTopConstraint.isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.isExpanded = false
    }
    
    private func setupMenuView() {
        menuView.collectionView.alpha = 0
        menuView.summonVehicleButton.alpha = 0
        menuView.expandButton.addTarget(self, action: #selector(expandButtonPressed), for: .touchUpInside)
        menuView.summonVehicleButton.addTarget(self, action: #selector(summonVehicle), for: .touchUpInside)
        
        addSwipeMenuGestureRecognizers()
    }
    
    private func setupActivityIndicatorLayout() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func getData() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.setupVehiclesOnMap()
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
            self?.menuView.collectionView.fadeIn(duration: 0.5)
            self?.menuView.summonVehicleButton.fadeIn(duration: 1.5)
        }
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation
        for vehicle in vehiclesAvailable {
            if annotation?.title == vehicle.name && annotation?.subtitle == "\(vehicle.charge)% charge" {
                let selectedVehicle = vehicle
                menuView.chosenVehicle = selectedVehicle
                menuView.selectedVehicleIsAvailable = selectedVehicle.charge > 0
                menuView.collectionView.reloadData()
            }
        }
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
            getRoute(for: chosenVehicle)
        }
    }
    
    private func showVehicleAlert(for vehicle: Vehicle, with expectedTime: TimeInterval) {
        
        let waitTimeSeconds = Int(expectedTime.truncatingRemainder(dividingBy: 60))
        let waitTimeMinutes = Int((expectedTime - Double(waitTimeSeconds)) / 60)
        let waitingTimeString = "\(waitTimeMinutes) minutes and \(waitTimeSeconds) seconds"

        let vehicleCallDetails = "\(vehicle.name), \(vehicle.charge)% charged, \(waitingTimeString) away"
        
        var alert = UIAlertController(title: "Call vehicle?", message: vehicleCallDetails, preferredStyle: .actionSheet)
        if UIDevice.current.userInterfaceIdiom == .pad {
            alert = UIAlertController(title: "Call vehicle?", message: vehicleCallDetails, preferredStyle: .alert)
        }

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
        }))
        
        alert.addAction(UIAlertAction(title: "Nah", style: .cancel, handler: { (action) in
            self.zoomOutMap()
            self.mapView.removeOverlays(self.mapView.overlays)
        }))
        self.present(alert, animated: true)
    }
    
    private func getRoute(for vehicle: Vehicle) {
        let startPlacemark = MKPlacemark(coordinate: vehicle.location)
        let destinationPlacemark = MKPlacemark(coordinate: currentFictionalLocation)
        
        let startMapItem = MKMapItem(placemark: startPlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = startMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            guard let response = response else { return }
            
            self.mapView.removeOverlays(self.mapView.overlays)
            if let route = response.routes.first {
                
                self.showVehicleAlert(for: self.menuView.chosenVehicle!, with: route.expectedTravelTime)
                self.mapView.addOverlay((route.polyline), level: .aboveRoads)
                
                let region = route.polyline.boundingMapRect.insetBy(dx: -5000, dy: -5000)
                
                self.mapView.setRegion(MKCoordinateRegion(region), animated: true)
            }
        }
    }
    
    private func showOnMap(center location: CLLocationCoordinate2D, around radius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: radius, longitudinalMeters: radius)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func zoomOutMap() {
        for annotation in mapView.selectedAnnotations {
            mapView.deselectAnnotation(annotation, animated: true)
        }
        let location = currentFictionalLocation
        let radius: CLLocationDistance = 10000
        showOnMap(center: location, around: radius)
    }
    
    private func animateMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            self.view.layoutIfNeeded()
            self.menuView.collectionView.reloadData()
        })
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = Themes.currentTheme.primaryAccentColor
        renderer.lineCap = .round
        renderer.lineWidth = 3.5
        
        return renderer
    }

}
