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
    
    var messages = [[Message]]()
    
    var numberOfLinesInTextView: CGFloat = 0
    
    let typingViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Themes.currentTheme.secondaryColor
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    let typingTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isScrollEnabled = false
        textView.contentInset.left = 15
        textView.contentInset.right = 15
        textView.backgroundColor = Themes.currentTheme.primaryColor
        textView.textColor = Themes.currentTheme.primaryFontColor
        textView.layer.cornerRadius = 15
        return textView
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = #imageLiteral(resourceName: "send-message-icon").withRenderingMode(.alwaysTemplate)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = Themes.currentTheme.primaryAccentColor
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        button.alpha = 0.25
        
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Themes.currentTheme.primaryColor
        tableView.alpha = 0
        
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.isHidden = true
        activityIndicatorView.color = Themes.currentTheme.tertiaryAccentColor
        
        return activityIndicatorView
    }()
    
    var typingTextViewBottomConstraint: NSLayoutConstraint!
    var typingTextViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Themes.currentTheme.primaryColor
        setupNavigationController()
        setupTableView()
        setupKeyboardObservers()

        setupTextInputLayout()
        typingTextView.delegate = self

        setupTableViewLayout()
        setupActivityIndicatorLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        super.viewWillDisappear(animated)
    }
    
    private func setupTableView() {
        tableView.register(MessageCell.self, forCellReuseIdentifier: messagesCellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.contentInset.top = 20
    }
    
    private func setupNavigationController() {
        if let navigationController = navigationController, navigationController.navigationBar.isHidden {
            navigationController.navigationBar.alpha = 0
            navigationController.navigationBar.isHidden = false
            UIView.animate(withDuration: 1) {
                navigationController.navigationBar.alpha = 1
            }
        }
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTextInputLayout() {
        view.addSubview(typingViewContainer)
        typingViewContainer.addSubview(typingTextView)
        typingViewContainer.addSubview(sendMessageButton)
        
        typingViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        typingViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        typingViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 15).isActive = true
        typingViewContainer.topAnchor.constraint(equalTo: typingTextView.topAnchor, constant: -10).isActive = true

        
        typingTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        typingTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60).isActive = true
        typingTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        
        typingTextViewBottomConstraint = typingTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        typingTextViewBottomConstraint.isActive = true
        
        
        sendMessageButton.leadingAnchor.constraint(equalTo: typingTextView.trailingAnchor, constant: 14).isActive = true
        sendMessageButton.bottomAnchor.constraint(equalTo: typingTextView.bottomAnchor, constant: -4).isActive = true
        sendMessageButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -14).isActive = true
        sendMessageButton.heightAnchor.constraint(equalTo: sendMessageButton.widthAnchor).isActive = true
    }
    
    private func setupTableViewLayout() {
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: typingViewContainer.topAnchor).isActive = true
    }
    
    private func setupActivityIndicatorLayout() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    
    private func getData() {
        sendMessageButton.isEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
            self?.getMessages()
            self?.tableView.reloadData()
            self?.sendMessageButton.fadeIn(duration: 2)
            self?.sendMessageButton.isEnabled = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.tableView.fadeIn(duration: 1)
            self?.scrollToLastMessage()
        }
    }
    
    private func getMessages() {
        messages = []
        
        var relevantMessages = Messages.foodMessages
        let categoryRelevantMessage = Message(author: "Joe", date: Date.fromString("02/05/2020"), text: "We're still talking about \(title ?? "something"), right?")
        relevantMessages.append(categoryRelevantMessage)
        
        let groupedMessages = Dictionary(grouping: relevantMessages, by: { (element) -> Date in
            return element.date
        })
        for date in groupedMessages.keys.sorted() {
            messages.append(groupedMessages[date] ?? [])
        }

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
        if let keyboardHeightOffset = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            var bottomPadding: CGFloat = -10
            if view.safeAreaInsets.bottom != 0 {
                bottomPadding += view.safeAreaInsets.bottom
            }
            
            typingTextViewBottomConstraint.constant = -keyboardHeightOffset + bottomPadding
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            scrollToLastMessage()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        typingTextViewBottomConstraint.constant = -10
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardDidHide(notification: NSNotification) {
        scrollToLastMessage()
    }
    
    @objc private func sendMessage() {
        Messages.foodMessages.append(Message(author: User.username, date: Date.fromString("05/06/2020"), text: typingTextView.text!))
        typingTextView.text = ""
        typingTextView.resignFirstResponder()
        getMessages()
        tableView.reloadData()
        scrollToLastMessage()
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
