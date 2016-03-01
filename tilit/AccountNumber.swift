//
//  AccountNumber.swift
//  tilit
//
//  Created by Touko Hallasmaa on 01.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//

import UIKit

class AccountNumber: NSObject, NSCoding {
    let contactName: String
    let accountNumber: String
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("data")
    
    struct PropertyKey {
        static let contactNameKey = "name"
        static let accountNumberKey = "account"
    }
    
    init(contactName: String, accountNumber: String) {
        self.contactName = contactName
        self.accountNumber = accountNumber
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(contactName, forKey: PropertyKey.contactNameKey)
        aCoder.encodeObject(accountNumber, forKey: PropertyKey.accountNumberKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.contactNameKey) as! String
        let account = aDecoder.decodeObjectForKey(PropertyKey.accountNumberKey) as! String
        // Must call designated initializer.
        self.init(contactName: name, accountNumber: account)
    }
}
