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
    
    var selectedItemIndexPath: IndexPath?
    
    let upIcon = #imageLiteral(resourceName: "up-icon").withRenderingMode(.alwaysTemplate)
    let downIcon = #imageLiteral(resourceName: "down-icon").withRenderingMode(.alwaysTemplate)

    var vehicleIsAvailable = false {
        didSet {
            summonVehicleButton.isEnabled = vehicleIsAvailable
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
        button.backgroundColor = secondaryFontColor
        button.titleLabel?.textColor = primaryColor
        button.setTitle("Summon Vehicle", for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.isEnabled = false
        
        return button
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = primaryColor
        
        return view
    }()
    
    let expandButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.tintColor = tertiaryRedColor
        
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
        let canSummonVehicle = vehicleIsAvailable
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            self.summonVehicleButton.backgroundColor = canSummonVehicle ? tertiaryRedColor : secondaryFontColor
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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
        
        let vehicle = vehicles[indexPath.item]
        
        if let image = UIImage(named: "transit-\(vehicle.name.lowercased())") {
            cell.imageView.image = image.withRenderingMode(.alwaysTemplate)
        }
        cell.count = vehicles[indexPath.item].count
        if isExpanded {
            cell.label.text = vehicle.name
            cell.countLabel.text = vehicle.count > 0 ? String(vehicle.count) : "(unavailable)"
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
        vehicleIsAvailable = vehicles[indexPath.item].count != 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
