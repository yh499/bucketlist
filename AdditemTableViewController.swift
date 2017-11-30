//
//  AdditemTableViewController.swift
//  bucketlist
//
//  Created by Yukie Hirano on 11/6/17.
//  Copyright © 2017 Yukie Hirano. All rights reserved.
//

import UIKit

class AdditemTableViewController: UITableViewController {
    
    weak var delegate: AddItemTableViewControllerDelegate?
    
    var item: String?
    var indexPath: NSIndexPath?

    @IBOutlet weak var itemTextField: UITextField!
    
    
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelPressed(by: self)
    }
    
    @IBAction func savedButtonPressed(_ sender: UIBarButtonItem) {
        let text = itemTextField.text!
        delegate?.itemSaved(by: self, with: text, at: indexPath)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }




}
