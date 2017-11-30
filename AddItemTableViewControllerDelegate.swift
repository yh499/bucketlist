//
//  AddItemTableViewControllerDelegate.swift
//  bucketlist
//
//  Created by Yukie Hirano on 11/6/17.
//  Copyright © 2017 Yukie Hirano. All rights reserved.
//

import Foundation

protocol AddItemTableViewControllerDelegate: class {
    func itemSaved(by controller: AdditemTableViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelPressed(by controller: AdditemTableViewController)
    
}
