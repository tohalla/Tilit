//
//  AccountNumberItemView.swift
//  tilit
//
//  Created by Touko Hallasmaa on 01.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//

import UIKit

class AccountNumberItemView: UIView {
    let accountNameLabel: UILabel
    let accountNumberLabel: UILabel
    
    init(frame: CGRect, accountNumber: AccountNumber) {
        accountNameLabel = UILabel()
        accountNumberLabel = UILabel()
        
        super.init(frame: frame)
        
        accountNameLabel.text = accountNumber.accountName
        accountNameLabel.translatesAutoresizingMaskIntoConstraints = false
        accountNumberLabel.text = accountNumber.accountNumber
        accountNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(accountNameLabel)
        addSubview(accountNumberLabel)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": accountNameLabel, "v1": accountNumberLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}