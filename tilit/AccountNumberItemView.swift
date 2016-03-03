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
    let pinnedIndicator: UIView
    
    init(accountNumber: AccountNumber) {
        accountNameLabel = UILabel()
        accountNumberLabel = UILabel()
        pinnedIndicator = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 5))
        
        super.init(frame: CGRect.zeroRect)

        accountNameLabel.text = accountNumber.accountName
        accountNameLabel.translatesAutoresizingMaskIntoConstraints = false
        accountNameLabel.font = UIFont.boldSystemFontOfSize(16.0)
        accountNumberLabel.text = accountNumber.accountNumber
        accountNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        accountNumberLabel.font = UIFont.systemFontOfSize(12)
        
        pinnedIndicator.backgroundColor = UIColor(red: 0.2, green: 1.0, blue: 0.1, alpha: 0.4)

        addSubview(accountNameLabel)
        addSubview(accountNumberLabel)
        if (accountNumber.pinned) {
          addSubview(pinnedIndicator)
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": accountNameLabel, "v1": accountNumberLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}