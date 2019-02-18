//
//  EventsVC.swift
//  MARS
//
//  Created by Mac on 2/17/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class EventsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let eventCellId = "EventCellId"
    
    let inset: CGFloat = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController, navigationController.navigationBar.isHidden {
            navigationController.navigationBar.alpha = 0
            navigationController.navigationBar.isHidden = false
            UIView.animate(withDuration: 1) {
                navigationController.navigationBar.alpha = 1
            }
        }
        navigationItem.title = "Upcoming Events"
        
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: navigationController!.navigationBar.frame.height + 60, left: inset, bottom: 2 * inset, right: inset)
            layout.minimumLineSpacing = 20
        }
        collectionView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: eventCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 2 * inset, height: 325)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingEvents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellId, for: indexPath) as! EventCell
        let event = upcomingEvents[indexPath.item]
        
        cell.thumbnailView.image = UIImage(named: event.imageName)
        cell.titleLabel.text = event.title
        cell.dateLabel.text = "november 12"
        
        return cell
    }
    

    
}
