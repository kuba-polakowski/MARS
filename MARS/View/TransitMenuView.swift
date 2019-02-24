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
    
    let imageNames = ["transit-bike", "transit-bicycle", "transit-quad", "transit-car", "transit-helicopter"]
    
    let upIcon = #imageLiteral(resourceName: "up-icon").withRenderingMode(.alwaysTemplate)
    let downIcon = #imageLiteral(resourceName: "down-icon").withRenderingMode(.alwaysTemplate)

    var isExpanded = false {
        didSet {
            collectionView.isScrollEnabled = isExpanded
            topIcon.image = isExpanded ? downIcon : upIcon
        }
    }
    
    let topIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = tertiaryRedColor
        imageView.image = #imageLiteral(resourceName: "up-icon").withRenderingMode(.alwaysTemplate)
        
        return imageView
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    var collectionViewHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = primaryColor

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isScrollEnabled = false
        
        addSubview(topIcon)
        topIcon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        topIcon.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        topIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true

        addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        collectionView.register(TransitMenuCell.self, forCellWithReuseIdentifier: transitCellId)
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
        if let image = UIImage(named: imageNames[indexPath.item]) {
            cell.imageView.image = image.withRenderingMode(.alwaysTemplate)
        }
        if isExpanded {
            cell.label.text = imageNames[indexPath.item].split(separator: "-")[1].capitalized
        }
        if selectedItemIndexPath != nil {
            cell.isSelected = indexPath == selectedItemIndexPath
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
        selectedItemIndexPath = indexPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
