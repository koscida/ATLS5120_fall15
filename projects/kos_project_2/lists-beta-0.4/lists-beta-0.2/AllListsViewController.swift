//
//  AllListsViewController.swift
//  lists-beta-0.2
//
//  Created by Brittany Kos on 10/25/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//
//
//  TONS of code adapted from this website:
//  http://www.raywenderlich.com/115695/getting-started-with-core-data-tutorial
//  However, most (>80%) of it is mine that I have re-written or heavily adapted to suit my needs
//
//  http://themsaid.github.io/2015/04/17/core-data-from-scratch-with-swift-2/
//


import UIKit
import CoreData

class AllListsViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    // create a context variable, this is the context for the app?
    var managedObjectContext: NSManagedObjectContext? = nil
    
    // create a local lists array, will hold all the lists to pop table view with
    var lists = [ListModel]()
    
    var error: NSError?
    
    
    
    /* ************************************************* */
    /*          MARK - ViewController Methods            */
    /* ************************************************* */
    
    // reg
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // reg
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add edit button to left side of navigation
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    // load the table data from core data and store in local lists variable
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "List")
        let fetchResults = managedContext?.executeFetchRequest(fetchRequest, error: &error) as? [ListModel]
        
        if let results = fetchResults {
            lists = results
            
        } else {
            println("Could not fetch \(error)")
        }
        
        /*
        println("-----------  AllLists - viewWillAppear  -----------")
        println("\nlists")
        println(lists)
        println("\n\n\n\n\n")
        */
        
        
        // delete everything
        /*
        for l in lists {
            managedContext!.deleteObject(l)
        }
        if !managedContext!.save(&error){
            println("Could not delete \(error), \(error!.userInfo)")
        }
        */
        
    }

    // reg
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    /* ********************************* */
    /*          MARK - Segues            */
    /* ********************************* */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showList" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                (segue.destinationViewController as! ListDetailViewController).detailList = true
                (segue.destinationViewController as! ListDetailViewController).objectID = (lists[indexPath.row]).objectID
            }
        }
        if segue.identifier == "addList" {
            (segue.destinationViewController as! ListEditViewController).navigationTitle = "New List"
            (segue.destinationViewController as! ListEditViewController).newList = true
        }
    }
    
    
    

    /* ****************************************************** */
    /*          MARK - Table View Delegate Methods            */
    /* ****************************************************** */

    // reg
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        //return self.fetchedResultsController.sections?.count ?? 0
    }
    
    // reg
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }

    // reg
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let list = lists[indexPath.row]
        cell.textLabel!.text = list.valueForKey("name") as? String
        
        return cell
    }

    // reg
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    // delete the row in table
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // remove from table view
            lists.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            // remove from core data
            managedObjectContext!.deleteObject(lists[indexPath.row])
            if managedObjectContext!.save(&error){
                println("List is deleted")
            }else{
                println("Could not delete \(error)")
            }
            
        }
    }
    
}

