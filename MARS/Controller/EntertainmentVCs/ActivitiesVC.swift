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
    
    func setupBarItem() {
        let image = #imageLiteral(resourceName: "activity-icon")
        tabBarItem = UITabBarItem(title: "Activities", image: image, tag: 0)
    }

}
