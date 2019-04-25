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

    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Events"
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: eventCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.isUserInteractionEnabled = true
        if events.isEmpty {
            getData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 2 * standardCollectionViewInset - view.safeAreaInsets.left - view.safeAreaInsets.right
        return CGSize(width: width, height: 320)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellId, for: indexPath) as! EventCell
        let event = events[indexPath.item]
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
    
    private func getData() {
        collectionView.alpha = 0
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
            self?.events = Events.upcomingEvents
            self?.collectionView.reloadData()
            self?.collectionView.fadeIn(duration: 1)
        }
    }
    
    private func animateToDetailView(chosenCell: EventCell, at index: IndexPath) {
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
                
                UIView.animate(withDuration: 0.5, animations: { [unowned self] in
                    self.collectionView.backgroundColor = Themes.currentTheme.primaryColor
                }, completion: { (_) in
                    let eventDetailVC = EventDetailVC()
                    eventDetailVC.event = self.events[index.row]
                    eventDetailVC.animationOffset = originY - currentOffset
                    eventDetailVC.modalTransitionStyle = .crossDissolve
                    self.navigationController?.present(eventDetailVC, animated: false, completion: nil)
                })
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.collectionView.backgroundColor = Themes.currentTheme.secondaryColor
            chosenCell.setOriginalConstraints()
            chosenCell.eventView.clipsToBounds = true
            chosenCell.frame.origin.y = originY
        }
        
    }
    
    
}
