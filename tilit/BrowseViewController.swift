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
        browseView.delegate = self
        
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
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let pin = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Pin") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) in
        }
        let share = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Share") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) in
        }
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Delete") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) in
            self.accountNumbers.removeAtIndex(indexPath.item)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            NSKeyedArchiver.archiveRootObject(self.accountNumbers, toFile: AccountNumber.ArchiveURL.path!)
        }
        pin.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 1.0)
        delete.backgroundColor = UIColor(red: 0.9, green: 0.4, blue: 0.1, alpha: 1.0)
        share.backgroundColor = UIColor(red: 0.16, green: 0.76, blue: 0.96, alpha: 1.0)
        
        return [delete, share, pin]
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

