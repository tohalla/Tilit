//
//  BrowseViewController.swift
//  tilit
//
//  Created by Touko Hallasmaa on 01.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//

import UIKit

class BrowseViewController: UICollectionViewController {
    private let cellIdentifier: String = "AccountNumber"
    private var accountNumbers = [AccountNumber]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = UIColor.whiteColor()
        
        accountNumbers = loadAccounts()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        collectionView?.registerClass(AccountNumberItemView.self, forCellWithReuseIdentifier: cellIdentifier)
        
        // nav
        title = "Browse"
        navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNew:"), animated: false)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 40);
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! AccountNumberItemView
        cell.accountNameLabel.text = accountNumbers[indexPath.item].accountName
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accountNumbers.count
    }
    
    func addNew(sender: UIBarButtonItem) {
        let addViewController = AddViewController(style: UITableViewStyle.Plain, saveHandler: addAccount)
        navigationController?.pushViewController(addViewController, animated: false)
    }

    
    func loadAccounts() -> [AccountNumber] {
        let loaded = NSKeyedUnarchiver.unarchiveObjectWithFile(AccountNumber.ArchiveURL.path!) as? [AccountNumber]
        return loaded == nil ? [AccountNumber]() : loaded!
    }
    
    func addAccount(accountNumber: AccountNumber) {
        accountNumbers.append(accountNumber)
        collectionView?.insertItemsAtIndexPaths([NSIndexPath(forRow: accountNumbers.count-1, inSection: 0)])
        NSKeyedArchiver.archiveRootObject(accountNumbers, toFile: AccountNumber.ArchiveURL.path!)
    }
}

