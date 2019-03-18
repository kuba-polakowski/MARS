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

    let goBackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = #imageLiteral(resourceName: "back-icon").withRenderingMode(.alwaysTemplate)
        button.imageView?.tintColor = primaryColor
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = secondaryColor
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: 2 * inset, right: inset)
            layout.minimumLineSpacing = 20
        }
        
        collectionView.backgroundColor = secondaryColor
        
        collectionView.contentInsetAdjustmentBehavior = .always
        
        collectionView.register(ActivityCell.self, forCellWithReuseIdentifier: activitiesCellId)
        
        setupBackButtonLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = view.frame.width < 420 ? (view.frame.width - 3 * inset) / 2 : 180
        if indexPath.item % 3 == 0 {
            width = 2 * width + inset
        }
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: activitiesCellId, for: indexPath) as! ActivityCell
        cell.imageView.image = #imageLiteral(resourceName: "macaw")
        cell.isCellBig = indexPath.item % 3 == 0
        cell.titleLabel.text = "LABEL"
        cell.detailLabel.text = "Some random text, whatever, it's just a description, noone's going to read it anyway. Might as well write some gibberish in here. Or something."
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsView = ActivityDetailView()
        showEventDetailView(detailsView)
    }
    
    func setupBackButtonLayout() {
        view.addSubview(goBackButton)
        goBackButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        goBackButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        goBackButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func showEventDetailView(_ detailsView: UIView) {
        detailsView.alpha = 0
        view.addSubview(detailsView)
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        detailsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        detailsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        detailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        detailsView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        detailsView.fadeIn(duration: 0.7)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: {
            detailsView.transform = .identity
        })
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupBarItem() {
        let image = #imageLiteral(resourceName: "activity-icon")
        tabBarItem = UITabBarItem(title: "Activities", image: image, tag: 0)
    }

}
