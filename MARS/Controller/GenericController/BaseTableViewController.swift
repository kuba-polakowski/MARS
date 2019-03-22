////
////  BaseTableViewController.swift
////  MARS
////
////  Created by Mac on 2/12/19.
////  Copyright © 2019 kubapolakowski. All rights reserved.
////
//
//
//// TODO: MAYBE IMPLEMENT GENERIC TABLEVIEWS
//
//import UIKit
//
//class BaseTableViewController<T: UITableViewCell>: UITableViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.register(T.self, forCellReuseIdentifier: baseCellId)
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20
//    }
//
//    let baseCellId = "baseCellId"
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: baseCellId, for: indexPath)
//        cell.textLabel?.text = "\(indexPath.row)"
//        return cell
//    }
//
//}
