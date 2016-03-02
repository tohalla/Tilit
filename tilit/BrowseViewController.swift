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
        
        accountNumbers.append(AccountNumber(contactName: "test", accountNumber: "123"))
        accountNumbers.append(AccountNumber(contactName: "test2", accountNumber: "321"))
        
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
        cell.contactNameLabel.text = accountNumbers[indexPath.item].contactName
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accountNumbers.count
    }
    
    func addNew(sender: UIBarButtonItem) {
        navigationController?.pushViewController(AddViewController(), animated: false)
    }
}

