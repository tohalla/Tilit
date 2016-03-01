//
//  BrowseViewController.swift
//  tilit
//
//  Created by Touko Hallasmaa on 01.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = UIColor.whiteColor()
        
        title = "Browse"
        
        let layout = UICollectionViewFlowLayout()
        let accountNumberListViewController = AccountNumberListViewController(collectionViewLayout: layout)
        addChildViewController(accountNumberListViewController)
        view.addSubview(accountNumberListViewController.view)
    }
}

