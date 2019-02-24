//
//  TransitVC.swift
//  MARS
//
//  Created by Mac on 2/23/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class TransitVC: UIViewController {
    
    let menuView: TransitMenuView = {
        let menuView = TransitMenuView()
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        return menuView
    }()
    
    var menuTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = secondaryRedColor
        
        setupMenuView()
        addSwipeMenuGestureRecognizers()
    }
    
    private func addSwipeMenuGestureRecognizers() {
        let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(expandMenu))
        swipeUpRecognizer.direction = .up
        menuView.addGestureRecognizer(swipeUpRecognizer)

        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(collapseMenu))
        swipeDownRecognizer.direction = .down
        menuView.addGestureRecognizer(swipeDownRecognizer)
        
    }

    @objc private func expandMenu() {
        guard menuTopConstraint.constant == -105 else { return }
        menuTopConstraint.constant = -300
        menuView.isExpanded = true
        animateMenu()
    }
    
    @objc private func collapseMenu() {
        guard menuTopConstraint.constant == -300 else { return }
        menuTopConstraint.constant = -105
        menuView.isExpanded = false
        animateMenu()
    }
    
    func animateMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            self.view.layoutIfNeeded()
            self.menuView.collectionView.reloadData()
        })
    }
    
    private func setupMenuView() {
        view.addSubview(menuView)
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuTopConstraint = menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -105)
        menuTopConstraint.isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}
