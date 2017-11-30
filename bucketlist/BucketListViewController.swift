//
//  ViewController.swift
//  bucketlist
//
//  Created by Yukie Hirano on 11/6/17.
//  Copyright © 2017 Yukie Hirano. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {

    var items = [BucketLIstItem]()
    //add this line:
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        print("Loaded")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //how many cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListitemCell", for: indexPath)
        //changing this line
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        manageObjectContext.delete(item)
        
        do {
            try manageObjectContext.save()
        } catch {
            print("\(error)")
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EdititemSegue", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "AddItemSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AdditemTableViewController
            addItemTableViewController.delegate = self
            
        } else if segue.identifier == "EdititemSegue" {
            
            let navigationController = segue.destination as! UINavigationController
            let addItemTableViewController = navigationController.topViewController as! AdditemTableViewController
            addItemTableViewController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            //changing this line
            addItemTableViewController.item = item.text!
            addItemTableViewController.indexPath = indexPath
            
        }
        
    }
    
    //adding this part
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketLIstItem")
        do {
            let result = try manageObjectContext.fetch(request)
            items = result as! [BucketLIstItem]
        } catch {
            print ("\(error)")
        }
        
    }
    
    
    func cancelPressed(by controller: AdditemTableViewController) {
      //  print("I am the hidden controller, but I am responding to the cancel press on the top view.")
        dismiss(animated: true, completion: nil)
    }

    func itemSaved(by controller: AdditemTableViewController, with text: String, at indexPath: NSIndexPath?) {
       // print("Received text: \(text)")
        if let ip = indexPath {
            let item = items[ip.row]
            item.text = text
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketLIstItem", into: manageObjectContext) as! BucketLIstItem
            item.text = text
            items.append(item)
        }
        do {
            try manageObjectContext.save()
        } catch {
            print("")
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    
}

