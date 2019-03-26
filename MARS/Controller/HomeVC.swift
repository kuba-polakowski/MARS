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
    
    let inset: CGFloat = 15
    
    let themeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change Theme", for: .normal)
        button.backgroundColor = currentTheme.tertiaryAccentColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        
        button.addTarget(self, action: #selector(changeTheme), for: .touchUpInside)
        
        return button
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: 2 * inset, right: inset)
            layout.minimumLineSpacing = 20
        }
        
        collectionView.backgroundColor = currentTheme.secondaryColor
        
        collectionView.contentInsetAdjustmentBehavior = .always
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: menuCellId)
        collectionView.register(MenuHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: menuHeaderId)
        
        view.addSubview(themeButton)
        themeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        themeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        themeButton.widthAnchor.constraint(equalToConstant: 135).isActive = true
        themeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !UserDefaults.standard.isOnboardingDone() {
            present(OnboardingVC(), animated: false)
        }
    }
    
    @objc private func changeTheme() {
        currentTheme = currentTheme.isLight ? darkTheme : lightTheme
        UserDefaults.standard.setThemeIsLight(currentTheme.isLight)
        
        themeButton.backgroundColor = currentTheme.tertiaryAccentColor
        collectionView.backgroundColor = currentTheme.secondaryColor
        
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: menuHeaderId, for: indexPath) as! MenuHeaderView
        
        if let posterImage = UIImage(named: currentTheme.posterName) {
            header.imageView.image = posterImage
        } else {
            header.imageView.image = #imageLiteral(resourceName: "macaw")
        }

        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = view.safeAreaInsets.left + view.safeAreaInsets.right
        let width = view.frame.width < 420 ? (view.frame.width - 3 * inset) / 2 : (view.frame.width - 5 * inset - insets) / 4
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuCategories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as! MenuCell
        
        let category = menuCategories[indexPath.item]
        
        cell.category = category.category
        cell.label.text = category.name
        if let image = UIImage(named: category.iconName) {
            cell.imageView.image = image.withRenderingMode(.alwaysTemplate)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chosenCell = collectionView.cellForItem(at: indexPath) as! MenuCell
        let collectionViewLayout = UICollectionViewFlowLayout()
        navigationController?.navigationBar.barTintColor = currentTheme.primaryColor
        switch chosenCell.category! {
        case .events:
            navigationController?.pushViewController(EventsVC(collectionViewLayout: collectionViewLayout), animated: true)
        case .comms:
            navigationController?.pushViewController(ChatCategoriesVC(), animated: true)
        case .hydro:
            navigationController?.pushViewController(HydroGardenVC(collectionViewLayout: collectionViewLayout), animated: true)
        case .ls:
            navigationController?.pushViewController(LSStatsVC(collectionViewLayout: collectionViewLayout), animated: true)
        case .transit:
            navigationController?.pushViewController(TransitVC(), animated: true)
        case .fun:
            navigationController?.pushViewController(EntertainmentVC(), animated: true)
        }
    }


}

