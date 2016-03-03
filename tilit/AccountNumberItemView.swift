//
//  AccountNumberItemView.swift
//  tilit
//
//  Created by Touko Hallasmaa on 01.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//

import UIKit

class AccountNumberItemView : UICollectionViewCell {
    let accountNameLabel: UILabel
    let accountNumberLabel: UILabel
    
    override init(frame: CGRect) {
        
        accountNameLabel = UILabel()
        accountNameLabel.text = "test"
        accountNameLabel.translatesAutoresizingMaskIntoConstraints = false
            
        accountNumberLabel = UILabel()
        accountNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
            
        addSubview(accountNameLabel)
        addSubview(accountNumberLabel)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": accountNameLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}