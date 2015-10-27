//
//  ListEditViewController.swift
//  lists-beta-0.2
//
//  Created by Brittany Kos on 10/25/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit
import CoreData

class ListEditViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    
    // create a context variable, this is the context for the app or view?
    var managedObjectContext: NSManagedObjectContext? = nil
    
    // create an error for all the core data calls
    var error: NSError?
    
    
    // variables that should be sent in
    var newList = true
    var navigationTitle = ""
    
    // data maybe sent in
    var objectID: NSManagedObjectID = NSManagedObjectID()
    

    
    
    /* ************************************************* */
    /*          MARK - ViewController Methods            */
    /* ************************************************* */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = navigationTitle
        
        // sent from table view
        if(newList) {
            nameField.text = ""
            nameField.placeholder = "Name of list"
            
        // sent from detail view
        } else if(!newList) {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            var list = managedContext?.objectWithID(objectID) as! ListModel
            //println("list: "); println(list); println("\n\n\n\n")
            
            nameField.text = list.name
            
            /*
            println("-----------  EditList - viewWillAppear - newList  -----------")
            println("\nlist")
            println(list)
            println("\n\n\n\n\n")
            */

            
        // sent from ???
        }else {
            nameField.text = "Something went wrong, please try again."
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
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        nameField.resignFirstResponder()
    }
    
    
    

    /* ********************************* */
    /*          MARK - Segues            */
    /* ********************************* */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "doneEditing" {
            saveListToCoreData()
            (segue.destinationViewController as! ListDetailViewController).objectID = objectID
            (segue.destinationViewController as! ListDetailViewController).detailList = true
        }
    }
    
    func saveListToCoreData() {
        // get context
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // get values from the screen
        var name = nameField.text
        
        if(newList) {
            // create entity and the list
            let entity = NSEntityDescription.entityForName("List", inManagedObjectContext: managedContext!)
            var list = ListModel(entity: entity!, insertIntoManagedObjectContext: managedContext) as ListModel
            
            // update the data object
            list.setValue(name, forKey: "name")
            
            // save it
            if !managedContext!.save(&error){
                println("saveListToCoreData - new List - Could not save \(error)")
            }
            
            // store new object id
            objectID = list.objectID
            
        } else {
            // fetch entity and the list
            var list = managedContext?.objectWithID(objectID) as! ListModel
            
            // update the data object
            list.name = name
            
            // save it
            if !managedContext!.save(&error){
                println("saveListToCoreData - !newList - Could not save \(error)")
            }
        }
        
        
    }

}
