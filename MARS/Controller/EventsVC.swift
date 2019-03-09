//
//  EventsVC.swift
//  MARS
//
//  Created by Mac on 2/17/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

private let eventCellId = "EventCellId"

class EventsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: 2 * inset, right: inset)
            layout.minimumLineSpacing = 20
        }
        collectionView.backgroundColor = secondaryColor
        collectionView.contentInsetAdjustmentBehavior = .always
        
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: eventCellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.backgroundColor = secondaryColor
        if navigationController?.navigationBar.alpha == 0 {
            navigationController?.navigationBar.fadeIn(duration: 0.5)
        }
        view.isUserInteractionEnabled = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 2 * inset - view.safeAreaInsets.left - view.safeAreaInsets.right
        return CGSize(width: width, height: 325)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingEvents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellId, for: indexPath) as! EventCell
        let event = upcomingEvents[indexPath.item]
        
        cell.eventView.thumbnailView.image = UIImage(named: event.imageName)
        cell.eventView.titleLabel.text = event.title
        cell.eventView.dateLabel.text = event.date.asString()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chosenCell = collectionView.cellForItem(at: indexPath) as! EventCell
        animateToDetailView(cell: chosenCell, at: indexPath)
    }
    
    
    func animateToDetailView(cell: EventCell, at index: IndexPath) {
        view.isUserInteractionEnabled = false
        navigationController?.navigationBar.fadeOut(duration: 0.1)

        let originY = cell.frame.origin.y
        let currentOffset = collectionView.contentOffset.y

        for cell in collectionView.visibleCells as! [EventCell] {
            if !cell.isSelected {
                cell.fadeOut(duration: 0.2)
            }
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            cell.frame.origin.y = currentOffset
            cell.eventView.backgroundColor = primaryColor
            }, completion: { (_) in
                cell.animateForTransition(withInsets: self.view.safeAreaInsets)
                
                UIView.animate(withDuration: 1, animations: { [unowned self] in
                    self.collectionView.backgroundColor = primaryColor
                }, completion: { (_) in
                    let eventDetailVC = EventDetailVC()
                    eventDetailVC.event = upcomingEvents[index.row]
                    eventDetailVC.animationOffset = originY - currentOffset
                    eventDetailVC.modalTransitionStyle = .crossDissolve
                    self.navigationController?.present(eventDetailVC, animated: true, completion: nil)
                })
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            cell.setOriginalConstraints()
            cell.eventView.clipsToBounds = true
            cell.frame.origin.y = originY
        }
        
    }
    
    
}
