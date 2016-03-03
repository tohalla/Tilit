//
//  BrowseViewController.swift
//  tilit
//
//  Created by Touko Hallasmaa on 01.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//

import UIKit

class BrowseViewController: UITableViewController {
    private let browseView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
    private let cellIdentifier: String = "AccountNumber"
    private var accountNumbers = [AccountNumber]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        browseView.backgroundColor = UIColor.whiteColor()
        browseView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        browseView.dataSource = self
        
        browseView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view = browseView
        
        accountNumbers = loadAccounts()
        
        // nav
        title = "Browse"
        navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNew:"), animated: false)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = browseView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.addSubview(AccountNumberItemView(frame: CGRectMake(0, 0, view.bounds.width, 120), accountNumber: accountNumbers[indexPath.item]))
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        tableView?.insertRowsAtIndexPaths([NSIndexPath(forRow: accountNumbers.count-1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
        NSKeyedArchiver.archiveRootObject(accountNumbers, toFile: AccountNumber.ArchiveURL.path!)
    }
}

