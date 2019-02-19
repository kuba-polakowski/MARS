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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chosenCell = collectionView.cellForItem(at: indexPath) as! EventCell
        animateToDetailView(cell: chosenCell, at: indexPath)
    }
    
    
    func animateToDetailView(cell: EventCell, at index: IndexPath) {
        UIView.animate(withDuration: 0.1, animations: { [unowned self] in
            self.navigationController?.navigationBar.alpha = 0
        }) { (_) in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
                cell.frame.origin.y = self.collectionView.contentOffset.y
                cell.backgroundColor = primaryColor
            }, completion: { (_) in
                cell.clipsToBounds = false
                cell.leadingThumbnailConstraint.constant = -15
                cell.trailingThumbnailConstraint.constant = 15
                cell.heightThumbnailConstraint.constant += 10
                cell.dateLabelLeadingConstraint.constant = cell.frame.width - 110
                UIView.animate(withDuration: 4) {
                    cell.layoutIfNeeded()
                    cell.titleLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                }
            })
        }
        
        for cell in collectionView.visibleCells as! [EventCell]{
            UIView.animate(withDuration: 0.5) {
                if !cell.isSelected {
                    cell.alpha = 0
                }
            }
        }
        
    }
    
    
}
