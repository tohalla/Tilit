//
//  AddViewController.swift
//  tilit
//
//  Created by Touko Hallasmaa on 02.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//
import UIKit

class AddViewController: UITableViewController {
    private let addView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
    private let cellIdentifier = "AddItem"
    private var views = [UIView]()
    private var saveHandler: ((AccountNumber) -> Void)!
    private var nameField: UITextField
    private var accountNumberField: UITextField
    
    init(style: UITableViewStyle, saveHandler: ((accountNumber: AccountNumber) -> Void)!) {
        self.saveHandler = saveHandler;
        let fieldRect = CGRectMake(0, 0, addView.bounds.width, 30);
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
        super.viewDidLoad()
        
        views.append(nameField)
        views.append(accountNumberField)
        
        addView.backgroundColor = UIColor.whiteColor()
        addView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        addView.dataSource = self
        
        addView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view = addView
        
        // nav
        title = "Add Account"
        navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel:"), animated: false)
        navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "add:"), animated: false)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = addView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell!
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
        saveHandler(AccountNumber(accountName: nameField.text!, accountNumber: accountNumberField.text!))
        navigationController?.popToRootViewControllerAnimated(false)
    }
    
}



