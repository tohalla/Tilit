//
//  BrowseViewController.swift
//  tilit
//
//  Created by Touko Hallasmaa on 01.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//

import UIKit

class BrowseViewController: UITableViewController {
    private let cellIdentifier: String = "AccountNumber"
    private var accountNumbers = [AccountNumber]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.allowsSelection = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        accountNumbers = loadAccounts()
        sort(false)
        
        // nav
        title = "Browse"
        navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNew:"), animated: false)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        for sv in cell.subviews {
            sv.removeFromSuperview()
        }
        cell.addSubview(AccountNumberItemView(accountNumber: accountNumbers[indexPath.item]))
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountNumbers.count
    }
    
    // swipe menu for pin, copy and delete actions
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let cell = tableView.cellForRowAtIndexPath(indexPath);
        let pin = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Pin") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) in
            self.accountNumbers[indexPath.item].pinned = !self.accountNumbers[indexPath.item].pinned
            self.setEditing(false, animated: true)
            // refresh views in cell to indicate pin status
            for view in cell!.subviews {
                view.removeFromSuperview()
            }
            cell!.addSubview(AccountNumberItemView(accountNumber: self.accountNumbers[indexPath.item]))
            NSKeyedArchiver.archiveRootObject(self.accountNumbers, toFile: AccountNumber.ArchiveURL.path!)
            self.sort()
        }
        let copy = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Copy") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) in
            UIPasteboard.generalPasteboard().string = self.accountNumbers[indexPath.item].accountNumber
            self.setEditing(false, animated: true)
        }
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Delete") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) in
            self.accountNumbers.removeAtIndex(indexPath.item)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            NSKeyedArchiver.archiveRootObject(self.accountNumbers, toFile: AccountNumber.ArchiveURL.path!)
        }
        pin.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 1.0)
        delete.backgroundColor = UIColor(red: 0.9, green: 0.4, blue: 0.1, alpha: 1.0)
        copy.backgroundColor = UIColor(red: 0.16, green: 0.76, blue: 0.96, alpha: 1.0)
        
        return [delete, copy, pin]
    }
    
    func sort(reloadTableView: Bool = true) {
        accountNumbers = accountNumbers.sort({(a, b) in
            return a.pinned && !b.pinned || (a.pinned == b.pinned && a.accountName.uppercaseString < b.accountName.uppercaseString)
        })
        if (reloadTableView) {
            for cell in tableView.visibleCells {
                cell.removeFromSuperview()
            }
            tableView.reloadData()
        }
    }



    func addNew(sender: UIBarButtonItem) {
        let addViewController = AddViewController(style: UITableViewStyle.Plain, accountNumbers: accountNumbers, saveHandler: addAccount)
        navigationController?.pushViewController(addViewController, animated: false)
    }
    
    func loadAccounts() -> [AccountNumber] {
        let loaded = NSKeyedUnarchiver.unarchiveObjectWithFile(AccountNumber.ArchiveURL.path!) as? [AccountNumber]
        return loaded == nil ? [AccountNumber]() : loaded!
    }
    
    func addAccount(accountNumber: AccountNumber) {
        accountNumbers.append(accountNumber)
        sort()
        NSKeyedArchiver.archiveRootObject(accountNumbers, toFile: AccountNumber.ArchiveURL.path!)
    }
}

