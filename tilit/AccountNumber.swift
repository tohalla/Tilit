//
//  AccountNumber.swift
//  tilit
//
//  Created by Touko Hallasmaa on 01.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//

import UIKit

class AccountNumber: NSObject, NSCoding {
    var accountName: String
    var accountNumber: String
    var pinned: Bool
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("data")
    
    struct PropertyKey {
        static let accountNameKey = "name"
        static let accountNumberKey = "account"
        static let pinnedKey = "pinned"
    }
    
    init(accountName: String, accountNumber: String, pinned: Bool = false) {
        self.accountName = accountName
        let accountNumber = accountNumber.stringByReplacingOccurrencesOfString(" ", withString: "")
        self.accountNumber = ""
        for (index, character) in [Character](accountNumber.characters).enumerate() {
            if(index % 4 == 0) {
                self.accountNumber.append(Character(" "))
            }
            self.accountNumber.append(character)
        }
        self.pinned = pinned
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(accountName, forKey: PropertyKey.accountNameKey)
        aCoder.encodeObject(accountNumber, forKey: PropertyKey.accountNumberKey)
        aCoder.encodeObject(pinned, forKey: PropertyKey.pinnedKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.accountNameKey) as! String
        let account = aDecoder.decodeObjectForKey(PropertyKey.accountNumberKey) as! String
        let pinned = aDecoder.decodeObjectForKey(PropertyKey.pinnedKey) as! Bool
        // Must call designated initializer.
        self.init(accountName: name, accountNumber: account, pinned: pinned)
    }
}
