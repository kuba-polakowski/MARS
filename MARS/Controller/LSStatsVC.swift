//
//  LSStatsVC.swift
//  MARS
//
//  Created by Mac on 2/22/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

private let lSStatCellId = "LSStatCell"

class LSStatsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let inset: CGFloat = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "LS System Stats"
        
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true

        if let navigationController = navigationController, navigationController.navigationBar.isHidden {
            navigationController.navigationBar.alpha = 0
            navigationController.navigationBar.isHidden = false
            UIView.animate(withDuration: 1) {
                navigationController.navigationBar.alpha = 1
            }
        }

        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let padding: CGFloat = 50
            layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
            layout.minimumLineSpacing = padding
        }
        collectionView.backgroundColor = primaryColor
        collectionView.contentInsetAdjustmentBehavior = .always
        
        collectionView.register(LSStatCell.self, forCellWithReuseIdentifier: lSStatCellId)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width < 420 ? (view.frame.width - 3 * inset) / 2 : 180
        return CGSize(width: width, height: width)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lSCategories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: lSStatCellId, for: indexPath) as! LSStatCell
        let category = lSCategories[indexPath.item]
        cell.titleLabel.text = category.title
        cell.percentageLabel.text = "\(category.value * 100)%"
        cell.circleLayer.strokeColor = category.color.cgColor
        cell.animateCircle(after: Double(indexPath.item) * 0.3, toValue: category.value - 0.17)
        
        return cell
    }


}
