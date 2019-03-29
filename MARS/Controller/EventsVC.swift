//
//  EventsVC.swift
//  MARS
//
//  Created by Mac on 2/17/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

private let eventCellId = "EventCellId"

class EventsVC: BaseCollectionViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Events"
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: eventCellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.isUserInteractionEnabled = true
        collectionView.reloadData()
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 2 * standardCollectionViewInset - view.safeAreaInsets.left - view.safeAreaInsets.right
        return CGSize(width: width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingEvents.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellId, for: indexPath) as! EventCell
        let event = upcomingEvents[indexPath.item]
        if let eventImage = UIImage(named: event.imageName) {
            cell.eventView.thumbnailView.image = eventImage
        }
        cell.eventView.titleLabel.text = event.title
        cell.eventView.dateLabel.text = event.date.asString()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chosenCell = collectionView.cellForItem(at: indexPath) as! EventCell
        animateToDetailView(chosenCell: chosenCell, at: indexPath)
    }
    
    
    func animateToDetailView(chosenCell: EventCell, at index: IndexPath) {
        view.isUserInteractionEnabled = false
        navigationController?.navigationBar.fadeOut(duration: 0.1)

        let originY = chosenCell.frame.origin.y
        let currentOffset = collectionView.contentOffset.y

        for cell in collectionView.visibleCells as! [EventCell] {
            if !cell.isSelected {
                cell.fadeOut(duration: 0.2)
            }
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            chosenCell.frame.origin.y = currentOffset
            }, completion: { (_) in
                chosenCell.animateForTransition(withInsets: self.view.safeAreaInsets)
                
                UIView.animate(withDuration: 0.7, animations: { [unowned self] in
                    self.collectionView.backgroundColor = currentTheme.primaryColor
                }, completion: { (_) in
                    let eventDetailVC = EventDetailVC()
                    eventDetailVC.event = upcomingEvents[index.row]
                    eventDetailVC.animationOffset = originY - currentOffset
                    eventDetailVC.modalTransitionStyle = .crossDissolve
                    self.navigationController?.present(eventDetailVC, animated: false, completion: nil)
                })
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.collectionView.backgroundColor = currentTheme.secondaryColor
            chosenCell.setOriginalConstraints()
            chosenCell.eventView.clipsToBounds = true
            chosenCell.frame.origin.y = originY
        }
        
    }
    
    
}
