//
//  commsVC.swift
//  MARS
//
//  Created by Mac on 2/12/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

private let chatCellId = "chatCellId"

class ChatCategoriesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let chatSubjects = ["Work", "Food", "Recreation", "Transit"]
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = navigationController, navigationController.navigationBar.isHidden {
            navigationController.navigationBar.alpha = 0
            navigationController.navigationBar.isHidden = false
            UIView.animate(withDuration: 1) {
                navigationController.navigationBar.alpha = 1
            }
        }
        navigationItem.title = "Communications"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = 120
        tableView.backgroundColor = secondaryColor
        tableView.separatorStyle = .none
        tableView.contentInset.top = 20
        
        tableView.register(ChatCategoryCell.self, forCellReuseIdentifier: chatCellId)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatSubjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatCellId, for: indexPath) as! ChatCategoryCell
        let event = upcomingEvents[indexPath.item % 3]
        
        cell.categoryImageView.image = UIImage(named: event.imageName)
        cell.label.text = chatSubjects[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(MessagesVC(), animated: true)
    }


}
