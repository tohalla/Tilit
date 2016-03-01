//
//  AddViewController.swift
//  tilit
//
//  Created by Touko Hallasmaa on 02.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//
import UIKit

class AddViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = UIColor.whiteColor()
        
        title = "Add Account"
        navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel:"), animated: false)
        navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "add:"), animated: false)
    }
    
    func cancel(sender: UIBarButtonItem) {
        navigationController?.popToRootViewControllerAnimated(false)
    }
}


