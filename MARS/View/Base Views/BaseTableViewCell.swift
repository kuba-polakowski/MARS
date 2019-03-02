//
//  GenericTableViewCell.swift
//  MARS
//
//  Created by Mac on 2/12/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    let label = UILabel()
    
    let cellShapeView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        cellShapeView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cellShapeView)
        addSubview(label)
        
        cellShapeView.layer.cornerRadius = 15
        cellShapeView.clipsToBounds = true
        
        backgroundColor = .clear
        cellShapeView.backgroundColor = primaryColor
        label.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)

        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
