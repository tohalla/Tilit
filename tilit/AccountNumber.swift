//
//  AccountNumber.swift
//  tilit
//
//  Created by Touko Hallasmaa on 01.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//

import UIKit

class AccountNumber: NSObject, NSCoding {
    let accountName: String
    let accountNumber: String
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("data")
    
    struct PropertyKey {
        static let accountNameKey = "name"
        static let accountNumberKey = "account"
    }
    
    init(accountName: String, accountNumber: String) {
        self.accountName = accountName
        self.accountNumber = accountNumber
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(accountName, forKey: PropertyKey.accountNameKey)
        aCoder.encodeObject(accountNumber, forKey: PropertyKey.accountNumberKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.accountNameKey) as! String
        let account = aDecoder.decodeObjectForKey(PropertyKey.accountNumberKey) as! String
        // Must call designated initializer.
        self.init(accountName: name, accountNumber: account)
    }
}
