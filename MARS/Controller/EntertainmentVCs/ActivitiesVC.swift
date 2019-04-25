//
//  ActivitiesVC.swift
//  MARS
//
//  Created by Mac on 3/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

private let activitiesCellId = "activitiesCellId"

class ActivitiesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let inset: CGFloat = 15

    let detailsView: ActivityDetailView = {
        let view = ActivityDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.isHidden = true
        activityIndicatorView.color = Themes.currentTheme.primaryAccentColor
        
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupLayout()
        setupActivityIndicatorLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = view.safeAreaInsets.left + view.safeAreaInsets.right
        
        var width: CGFloat = 0
        if view.frame.width < 420 {
            width = (view.frame.width - 3 * inset) / 2
            if indexPath.item % 3 == 0 {
                width = 2 * width + inset
            }
        } else if view.frame.width < 800 {
            width = (view.frame.width - 6 * inset - insets) / 4
            if indexPath.item % 5 == 0 {
                width = 2 * width + inset
            }
        } else {
            width = (view.frame.width - 8 * inset - insets) / 6
            if indexPath.item % 7 == 0 {
                width = 2 * width + inset
            }
        }
        
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: activitiesCellId, for: indexPath) as! ActivityCell
        if view.frame.width < 420 {
            cell.isCellBig = indexPath.item % 3 == 0
        } else if view.frame.width < 800 {
            cell.isCellBig = indexPath.item % 5 == 0
        } else {
            cell.isCellBig = indexPath.item % 7 == 0
        }
        
        cell.activity = Activities.all.randomElement()
        
        cell.detailLabel.text = "Some random text, whatever, it's just a boring description. Only here to fill the bigger cells. Dynamic layout and stuff. Mad advanced, I know."
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chosenCell = collectionView.cellForItem(at: indexPath) as! ActivityCell
        if let title = chosenCell.titleLabel.text, let image = chosenCell.imageView.image {
            showEventDetailView(with: title, image: image)
            detailsView.activity = chosenCell.activity
        }
    }
    
    func setupLayout() {
        view.addSubview(detailsView)
        detailsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        detailsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        detailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        detailsView.isHidden = true
    }
    
    private func setupCollectionView() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: 2 * inset, right: inset)
            layout.minimumLineSpacing = 20
        }
        
        collectionView.backgroundColor = Themes.currentTheme.secondaryColor
        
        collectionView.contentInsetAdjustmentBehavior = .always
        
        collectionView.register(ActivityCell.self, forCellWithReuseIdentifier: activitiesCellId)
    }

    private func showEventDetailView(with title: String, image: UIImage) {
        guard detailsView.isHidden else { return }
        
        detailsView.titleLabel.text = title
        detailsView.thumbnailImageView.image = image
        detailsView.alpha = 0
        detailsView.isHidden = false
        detailsView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        detailsView.fadeIn(duration: 0.7)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.detailsView.transform = .identity
        })
    }
    
    private func setupActivityIndicatorLayout() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupBarItem() {
        let image = #imageLiteral(resourceName: "activity-icon")
        tabBarItem = UITabBarItem(title: "Activities", image: image, tag: 0)
    }

}
