//
//  AccountNumber.swift
//  tilit
//
//  Created by Touko Hallasmaa on 01.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//

struct AccountNumber {
    let contactName: String
    let accountNumber: String
    
    init(contactName: String, accountNumber: String) {
        self.contactName = contactName
        self.accountNumber = accountNumber
    }
}