//
//  LSStatsVC.swift
//  MARS
//
//  Created by Mac on 2/22/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

private let lSStatCellId = "LSStatCell"

class LSStatsVC: BaseCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LS System Stats"
        
        collectionView.register(LSStatCell.self, forCellWithReuseIdentifier: lSStatCellId)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = view.safeAreaInsets.left + view.safeAreaInsets.right
        let width = view.frame.width < view.frame.height ? (view.frame.width - 3 * standardCollectionViewInset) / 2 : (view.frame.width - 4 * standardCollectionViewInset - insets) / 3
        return CGSize(width: width, height: width)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lSCategories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: lSStatCellId, for: indexPath) as! LSStatCell
        let category = lSCategories[indexPath.item]
        cell.titleLabel.text = category.title
        cell.circleLayer.strokeColor = category.color.cgColor
        cell.delay = Double(indexPath.item)
        cell.value = category.value
        cell.percentageLabel.text = "\(category.value * 100)%"
        
        return cell
    }


}
