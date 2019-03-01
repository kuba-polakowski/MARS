//
//  MessagesVC.swift
//  MARS
//
//  Created by Mac on 2/13/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

private let messagesCellId = "messagesCellId"

class MessagesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let messages = foodMessages
    
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
        navigationItem.title = "Food"
        
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        tableView.separatorStyle = .none
        tableView.contentInset.top = 20
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: messagesCellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let lastSection = messages.last {
            let lastSectionIndex = messages.count - 1
            let lastRowIndex = lastSection.count - 1
            let lastIndexPath = IndexPath(row: lastRowIndex, section: lastSectionIndex)
            tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MessagesHeaderView()
        headerView.label.text = messages[section].first?.date.asString()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messagesCellId, for: indexPath) as! MessageCell
        let message = messages[indexPath.section][indexPath.row]
        
        cell.authorLabel.text = message.author
        cell.isIncoming = message.author != "Peter"
        cell.messageTextLabel.text = message.text
        
        cell.isContinuing = message.author == "Peter"
        if indexPath.row > 0 {
            let previousMessage = messages[indexPath.section][indexPath.row - 1]
            cell.isContinuing = message.author == previousMessage.author
        }
        
        return cell
    }
    
}
