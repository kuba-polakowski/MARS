//
//  MessagesVC.swift
//  MARS
//
//  Created by Mac on 2/13/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

private let messagesCellId = "messagesCellId"

class MessagesVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    let messages = foodMessages
    
    let typingViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = secondaryColor
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    let typingTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = primaryColor
        textView.textColor = primaryFontColor
        textView.layer.cornerRadius = 15
        
        return textView
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = #imageLiteral(resourceName: "send-message-icon").withRenderingMode(.alwaysTemplate)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = primaryRedColor
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var typingViewTopConstraint: NSLayoutConstraint!
    var tableViewBottomConstraint: NSLayoutConstraint!
    
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = primaryColor
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45)
        tableViewBottomConstraint.isActive = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = primaryColor
        tableView.separatorStyle = .none
        tableView.contentInset.top = 20
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: messagesCellId)
        
        
        view.addSubview(typingViewContainer)
        typingViewContainer.addSubview(typingTextView)
        typingViewContainer.addSubview(sendMessageButton)
        
        typingViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        typingViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        typingViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        typingViewTopConstraint = typingViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45)
        typingViewTopConstraint.isActive = true
        
        typingTextView.delegate = self
        typingTextView.leadingAnchor.constraint(equalTo: typingViewContainer.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        typingTextView.topAnchor.constraint(equalTo: typingViewContainer.topAnchor, constant: 10).isActive = true
        typingTextView.trailingAnchor.constraint(equalTo: typingViewContainer.safeAreaLayoutGuide.trailingAnchor, constant: -55).isActive = true
        typingTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        sendMessageButton.leadingAnchor.constraint(equalTo: typingTextView.trailingAnchor, constant: 15).isActive = true
        sendMessageButton.topAnchor.constraint(equalTo: typingViewContainer.topAnchor, constant: 10).isActive = true
        sendMessageButton.trailingAnchor.constraint(equalTo: typingViewContainer.trailingAnchor, constant: -10).isActive = true
        sendMessageButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToLastMessage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        super.viewWillDisappear(animated)
    }
    
    private func scrollToLastMessage() {
        if let lastSection = messages.last {
            let lastSectionIndex = messages.count - 1
            let lastRowIndex = lastSection.count - 1
            let lastIndexPath = IndexPath(row: lastRowIndex, section: lastSectionIndex)
            tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
        }
    }
    
    @objc private func keyboardWillAppear(notification: NSNotification) {
        if let keyboardHeightOffset = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height {
            typingViewTopConstraint.constant = -15 - keyboardHeightOffset
            tableViewBottomConstraint.constant = -15 - keyboardHeightOffset
            UIView.animate(withDuration: 2) {
                self.view.layoutIfNeeded()
            }
            scrollToLastMessage()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        typingViewTopConstraint.constant = -45
        tableViewBottomConstraint.constant = -45
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        }
        scrollToLastMessage()
    }
    
    @objc private func sendMessage() {
        print("sending: \(typingTextView.text!)")
        typingTextView.text = ""
        typingTextView.resignFirstResponder()
        
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
