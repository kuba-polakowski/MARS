//
//  BaseCollectionViewController.swift
//  MARS
//
//  Created by Mac on 3/27/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let standardCollectionViewInset: CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupFlowLayout()
        setupCollectionViewLayout()
        setupAdditionalViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fadeInNavigationBar()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }

    func setupFlowLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: standardCollectionViewInset, left: standardCollectionViewInset, bottom: 2 * standardCollectionViewInset, right: standardCollectionViewInset)
            layout.minimumLineSpacing = standardCollectionViewInset
        }
    }
    
    func setupCollectionViewLayout() {
        collectionView.backgroundColor = currentTheme.secondaryColor
        collectionView.contentInsetAdjustmentBehavior = .always
    }
    
    func setupAdditionalViews() {
        
    }
    
    func setupNavigationBar() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.prefersLargeTitles = true
            navigationItem.title = title
        }
    }
    
    func fadeInNavigationBar() {
        if let navigationBar = navigationController?.navigationBar, navigationBar.isHidden {
            navigationBar.alpha = 0
            navigationBar.isHidden = false
            navigationBar.fadeIn(duration: 0.5)
        }
    }
    
    
}
