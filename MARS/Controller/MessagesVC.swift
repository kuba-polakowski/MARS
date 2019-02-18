//
//  MessagesVC.swift
//  MARS
//
//  Created by Mac on 2/13/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class MessagesVC: UITableViewController {
    
    let messages = foodMessages
    
    let messagesCellId = "messagesCellId"
    
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
        
        tableView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        tableView.separatorStyle = .none
        tableView.contentInset.top = 20
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: messagesCellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let lastIndexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messagesCellId, for: indexPath) as! MessageCell
        let message = messages[indexPath.row]
        
        cell.label.text = message.text
        cell.authorLabel.text = message.author
        cell.isIncoming = message.author != "Peter"
        
        if indexPath.row > 0 {
            cell.isContinuing = message.author == "Peter" || message.author == messages[indexPath.row - 1].author
        } else {
            cell.isContinuing = false
        }
        
        return cell
    }
    
}
