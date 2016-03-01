//
//  AccountNumberItem.swift
//  tilit
//
//  Created by Touko Hallasmaa on 01.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//

import UIKit

class AccountNumberItem : UICollectionViewCell {
    let contactNameLabel: UILabel
    let accountNumberLabel: UILabel
    
    override init(frame: CGRect) {
        
        contactNameLabel = UILabel()
        contactNameLabel.text = "test"
        contactNameLabel.translatesAutoresizingMaskIntoConstraints = false
            
        accountNumberLabel = UILabel()
        accountNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
            
        addSubview(contactNameLabel)
        addSubview(accountNumberLabel)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": contactNameLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}