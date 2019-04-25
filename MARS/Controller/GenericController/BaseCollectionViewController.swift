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
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.isHidden = true
        activityIndicatorView.color = Themes.currentTheme.primaryAccentColor
        
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Themes.currentTheme.secondaryColor
        setupNavigationBar()
        setupFlowLayout()
        setupCollectionViewLayout()
        setupAdditionalViews()
        setupActivityIndicatorLayout()
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
        collectionView.backgroundColor = Themes.currentTheme.secondaryColor
        collectionView.contentInsetAdjustmentBehavior = .always
    }
    
    func setupAdditionalViews() {
    }
    
    private func setupActivityIndicatorLayout() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
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
