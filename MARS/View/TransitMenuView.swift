//
//  TransitMenuView.swift
//  MARS
//
//  Created by Mac on 2/23/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

private let transitCellId = "transitCellId"

class TransitMenuView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var chosenVehicle: Vehicle?
    
    let allVehiclesByType: [[Vehicle]] = {
        var allVehicles = [[Vehicle]]()
        let groupedVehicles = Dictionary(grouping: vehicles) { (element) -> String in
            return element.name
        }
        groupedVehicles.keys.forEach({ (vehicleType) in
            allVehicles.append(groupedVehicles[vehicleType] ?? [])
        })
        return allVehicles
    }()
    
    
    var selectedItemIndexPath: IndexPath?
    
    let upIcon = #imageLiteral(resourceName: "up-icon").withRenderingMode(.alwaysTemplate)
    let downIcon = #imageLiteral(resourceName: "down-icon").withRenderingMode(.alwaysTemplate)

    var selectedVehicleIsAvailable = false {
        didSet {
            summonVehicleButton.isEnabled = selectedVehicleIsAvailable
            animateSummonButton()
        }
    }
    
    var isExpanded = false {
        didSet {
            collectionView.isScrollEnabled = isExpanded
            let topIconImage = isExpanded ? downIcon : upIcon
            expandButton.setImage(topIconImage, for: .normal)
        }
    }
    
    let summonVehicleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = currentTheme.secondaryFontColor
        button.titleLabel?.textColor = currentTheme.primaryColor
        button.setTitle("Summon Vehicle", for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.isEnabled = false
        
        return button
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = currentTheme.primaryColor
        
        return view
    }()
    
    let expandButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.tintColor = currentTheme.primaryAccentColor
        
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    var summonButtonHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isScrollEnabled = false
        
        addSubview(summonVehicleButton)
        summonVehicleButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        summonVehicleButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        summonVehicleButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        summonVehicleButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        
        containerView.addSubview(expandButton)
        expandButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        expandButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        expandButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        expandButton.heightAnchor.constraint(equalToConstant: 25).isActive = true

        containerView.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: expandButton.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        collectionView.register(TransitMenuCell.self, forCellWithReuseIdentifier: transitCellId)
    }
    
    func animateSummonButton() {
        let canSummonVehicle = selectedVehicleIsAvailable
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.summonVehicleButton.backgroundColor = canSummonVehicle ? currentTheme.tertiaryAccentColor : currentTheme.secondaryFontColor
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allVehiclesByType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = frame.width - safeAreaInsets.left - safeAreaInsets.right
        let height = frame.width < 420 ? width / 5 : 80
        if !isExpanded {
            width = height
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: transitCellId, for: indexPath) as! TransitMenuCell
        
        let vehicleType = allVehiclesByType[indexPath.item]
        let vehicleExample = vehicleType.first!
        
        if let image = UIImage(named: "transit-\(vehicleExample.name.lowercased())") {
            cell.imageView.image = image.withRenderingMode(.alwaysTemplate)
        }
        var numberOfVehiclesOutOfJuice = 0
        var available: Bool {
            var available = false
            vehicleType.forEach({ (vehicle) in
                if vehicle.charge > 0 {
                    available = true
                } else {
                    numberOfVehiclesOutOfJuice += 1
                }
            })
            return available
        }
        
        cell.available = available
        
        if isExpanded {
            cell.label.text = vehicleExample.name
            cell.countLabel.text = available ? String(vehicleType.count) : "(unavailable)"
            if available && numberOfVehiclesOutOfJuice > 0 {
                cell.countLabel.text = " \(vehicleType.count) (\(numberOfVehiclesOutOfJuice) out of juice)"
            }
        } else {
            cell.label.text = ""
            cell.countLabel.text = ""
        }
        if selectedItemIndexPath != nil {
            cell.isSelected = indexPath == selectedItemIndexPath
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
        selectedItemIndexPath = indexPath
        
        let availableVehicles = allVehiclesByType[indexPath.item].filter { $0.charge > 0 }
        
        selectedVehicleIsAvailable = availableVehicles.count > 0
        if selectedVehicleIsAvailable {
            chosenVehicle = availableVehicles.randomElement()
        } else {
            chosenVehicle = nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
