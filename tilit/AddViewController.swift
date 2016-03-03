//
//  AddViewController.swift
//  tilit
//
//  Created by Touko Hallasmaa on 02.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//
import UIKit

class AddViewController: UITableViewController {
    private let cellIdentifier = "AddItem"
    private var views = [UIView]()
    private var saveHandler: ((AccountNumber) -> Void)!
    private var accountNumbers: [AccountNumber] // for validation
    private var nameField: UITextField
    private var accountNumberField: UITextField
    
    init(style: UITableViewStyle, accountNumbers: [AccountNumber], saveHandler: ((accountNumber: AccountNumber) -> Void)!) {
        self.accountNumbers = accountNumbers
        self.saveHandler = saveHandler;
        let fieldRect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 30);
        //initialize views
        nameField = UITextField(frame: fieldRect)
        nameField.placeholder = "Account name"
        
        accountNumberField = UITextField(frame: fieldRect)
        accountNumberField.placeholder = "Account number"
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let iban = UILabel(frame: CGRectMake(0, 0, tableView.frame.width, 40))
        super.viewDidLoad()
        
        iban.text = "Insert bank account number in iban format"
        iban.font = UIFont.systemFontOfSize(12)
        
        views.append(nameField)
        views.append(accountNumberField)
        views.append(iban)
        
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.allowsSelection = false
        
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        // nav
        title = "Add Account"
        navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel:"), animated: false)
        navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "add:"), animated: false)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell!
        cell.addSubview(views[indexPath.item])
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return views.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func cancel(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(false)
    }
    
    func add(sender: UIBarButtonItem) {
        if (isValid()) {
            saveHandler(AccountNumber(accountName: nameField.text!, accountNumber: accountNumberField.text!))
            navigationController?.popToRootViewControllerAnimated(false)
        }
    }

    func isValid() -> Bool {
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        if (nameField.text?.characters.count == 0) {
            alert.title = "Name"
            alert.message = "Insert name for the account"
            presentViewController(alert, animated: false, completion: nil)
            return false
        }
        for accountNumber in accountNumbers {
            if (accountNumber.accountName == nameField.text) {
                alert.title = "Name"
                alert.message = "Duplicate account name found"
                presentViewController(alert, animated: false, completion: nil)
                return false
            } else if (accountNumber.accountNumber == accountNumberField.text) {
                alert.title = "Iban"
                alert.message = "Duplicate account number found"
                presentViewController(alert, animated: false, completion: nil)
                return false
            }
        }
        if (!AccountNumberHelper.isBankNumberValid(accountNumberField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))) {
            alert.title = "Iban"
            alert.message = "Entered iban number didn't pass the check"
            presentViewController(alert, animated: false, completion: nil)
            return false
        }
        return true
    }
    
}



