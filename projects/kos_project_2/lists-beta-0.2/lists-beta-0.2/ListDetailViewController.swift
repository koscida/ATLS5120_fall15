//
//  ListDetailViewController.swift
//  lists-beta-0.2
//
//  Created by Brittany Kos on 10/25/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//
//  Action Sheet: 
//  http://www.ioscreator.com/tutorials/action-sheet-tutorial-ios8-swift

import UIKit
import CoreData

class ListDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var trashButton: UIToolbar!
    
    
    // create a context variable, this is the context for the app or view?
    var managedObjectContext: NSManagedObjectContext? = nil
    
    // create an error for all the core data calls
    var error: NSError?
    
    
    // data that should be sent in
    var detailList = false
    var objectID: NSManagedObjectID = NSManagedObjectID()
    
    
    
    /* ************************************************* */
    /*          MARK - ViewController Methods            */
    /* ************************************************* */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // sent from editing/table view
        if(detailList) {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            var list = managedContext?.objectWithID(objectID) as! ListModel
            //println("list: "); println(list); println("\n\n\n\n")
            
            nameLabel.text = list.name
            
            /*
            println("-----------  ListDetail - viewWillAppear  -----------")
            println("\nlist")
            println(list)
            println("\n\n\n\n\n")
            */
            
        // sent from ???
        } else {
            nameLabel.text = "Something went wrong, please try again."
            println("Something went wrong, did not send listID to view")
        }
        
        
    }
    
    
    // load the table data from core data and store in local lists variable
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteList(sender: UIBarButtonItem) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete List", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            // get list
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            var list = managedContext?.objectWithID(self.objectID) as! ListModel
            
            // remove from core data
            managedContext!.deleteObject(list)
            if managedContext!.save(&self.error){
                println("List is deleted")
            }else{
                println("Could not delete \(self.error)")
            }
            
            self.performSegueWithIdentifier("showTable", sender: self)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    

    
    
    /* ********************************* */
    /*          MARK - Segues            */
    /* ********************************* */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editList" {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            var list = managedContext?.objectWithID(objectID) as! ListModel
            
            (segue.destinationViewController as! ListEditViewController).navigationTitle = "Edit List"
            (segue.destinationViewController as! ListEditViewController).newList = false
            (segue.destinationViewController as! ListEditViewController).objectID = objectID
        }
        
        if segue.identifier == "showTable" {
        }
    }

}

