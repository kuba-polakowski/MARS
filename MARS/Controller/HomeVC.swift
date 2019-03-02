//
//  ViewController.swift
//  MARS
//
//  Created by Mac on 2/10/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

private let menuCellId = "menuCellId"
private let menuHeaderId = "menuHeaderId"

class HomeVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let menuItems = ["Events", "Comms", "Hydro", "LS", "Transit", "Fun", "News"]

    let inset: CGFloat = 15

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: 2 * inset, right: inset)
            layout.minimumLineSpacing = 20
        }
        collectionView.backgroundColor = secondaryColor
        
        collectionView.contentInsetAdjustmentBehavior = .always
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuCellId)
        collectionView.register(MenuHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: menuHeaderId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: menuHeaderId, for: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width < 420 ? (view.frame.width - 3 * inset) / 2 : 180
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! MenuCell
        cell.label.text = " " + menuItems[indexPath.item] + " "
        if let image = UIImage(named: menuItems[indexPath.item].lowercased()) {
            cell.imageView.image = image.withRenderingMode(.alwaysTemplate)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chosenCell = collectionView.cellForItem(at: indexPath) as! MenuCell
        if chosenCell.label.text == " Events " {
            let collectionViewLayout = UICollectionViewFlowLayout()
            navigationController?.pushViewController(EventsVC(collectionViewLayout: collectionViewLayout), animated: true)
        } else if chosenCell.label.text == " Hydro " {
            let collectionViewLayout = UICollectionViewFlowLayout()
            navigationController?.pushViewController(HydroGardenVC(collectionViewLayout: collectionViewLayout), animated: true)
        } else if chosenCell.label.text == " LS " {
            let collectionViewLayout = UICollectionViewFlowLayout()
            navigationController?.pushViewController(LSStatsVC(collectionViewLayout: collectionViewLayout), animated: true)
        } else if chosenCell.label.text == " Transit " {
            navigationController?.pushViewController(TransitVC(), animated: true)
        } else {
            navigationController?.pushViewController(ChatCategoriesVC(), animated: true)
        }
    }


}

