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
    @IBOutlet weak var organizeButton: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var organizedViews = [UIView]()
    
    
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
            // name field
            nameField.text = ""
            nameField.placeholder = "Name of list"
            
            scrollView.frame = CGRectMake(0, 0, self.view.frame.width, 0)
            scrollView.contentSize = CGSizeMake(self.view.frame.width, 0)

            addNewSection()
            
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
    
    
    
    /* ********************************************** */
    /*          MARK - View Action Methods            */
    /* ********************************************** */
    
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
    
    @IBAction func addSection(sender: UIBarButtonItem) {
        addNewSection()
    }
    
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        nameField.resignFirstResponder()
        for o in organizedViews {
            var ss = o.subviews
            for s in ss {
                s.resignFirstResponder()
            }
        }
        /*
        for view in self.view.subviews as! [UIView] {
            if let textField = view as? UITextField {
                if textField.text == "" {
                    // show error
                    return
                }
            }
        }
*/
    }
    
    func addNewSection() {
        var h: CGFloat = 0
        for o in organizedViews {
            h += o.frame.height
        }
        
        // get where the y position of new section will be
        var y = h
        
        // get total section height
        var sectionHeight: CGFloat = 8 + 30 + 8 + 30 + 8 + 30 + 8
        
        // get white color value
        var w: CGFloat = (organizedViews.count % 2 == 0) ? 240 : 250
        
        
        // add the section
        var sectionView = UIView(frame: CGRect(x: 0, y: y, width: scrollView.frame.width, height: sectionHeight))
        sectionView.backgroundColor = UIColor(white: w/255, alpha: 1)
        scrollView.addSubview(sectionView)
        organizedViews.append(sectionView)
        
        // add the name field inside of the section
        var sectionNameField = UITextField(frame: CGRectMake(8, 8, view.frame.width-16, 30))
        sectionNameField.backgroundColor = UIColor(white: 1, alpha: 1)
        sectionNameField.placeholder = "Section name"
        sectionView.addSubview(sectionNameField)
        
        // add the view for the items
        var itemsView = UIView()
        itemsView.restorationIdentifier = "itemsView"
        sectionView.addSubview(itemsView)
        
        // add the item inside of the section
        var sectionItemField = UITextField(frame: CGRectMake(8, 8+30+8, view.frame.width-16, 30))
        sectionItemField.backgroundColor = UIColor(white: 1, alpha: 1)
        sectionItemField.placeholder = "New item"
        itemsView.addSubview(sectionItemField)
        
        // get button width
        var bw: CGFloat = ((scrollView.frame.width-(4*8))/3)
        
        // add the show/hide toggle button
        var toggleSectionBtn = UIButton(frame: CGRectMake(8, 8+30+8+30+8, bw, 30))
        toggleSectionBtn.setTitle("Hide", forState: .Normal)
        toggleSectionBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        toggleSectionBtn.addTarget(self, action: "togglePressed:", forControlEvents: .TouchUpInside)
        sectionView.addSubview(toggleSectionBtn)
        
        // add the show/hide toggle button
        var deleteSectionBtn = UIButton(frame: CGRectMake(bw+16, 8+30+8+30+8, bw, 30))
        deleteSectionBtn.setTitle("Delete", forState: .Normal)
        deleteSectionBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        deleteSectionBtn.addTarget(self, action: "deletSectionPressed:", forControlEvents: .TouchUpInside)
        sectionView.addSubview(deleteSectionBtn)
        
        // add the add new item button
        var addItemBtn = UIButton(frame: CGRectMake((2*bw)+(8*3), 8+30+8+30+8, bw, 30))
        addItemBtn.setTitle("Add Item", forState: .Normal)
        addItemBtn.setTitleColor(UIColor.blueColor(), forState: .Normal)
        addItemBtn.addTarget(self, action: "addItemPressed:", forControlEvents: .TouchUpInside)
        sectionView.addSubview(addItemBtn)

        
        // change height of scroll view
        scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, self.view.frame.width, h+sectionHeight)
        scrollView.contentSize = CGSizeMake(self.view.frame.width, h+sectionHeight)
        
    }
    
    func togglePressed(sender: UIButton!) {
        var supa = sender.superview!
        for view in supa.subviews as! [UIView] {
            // Found it!!!
            if(view.restorationIdentifier == "itemsView") {
                // get view height
                var viewHeight: CGFloat = view.frame.height
                
                // change button text
                if(view.hidden) {
                    sender.setTitle("Hide", forState: .Normal)
                } else {
                    sender.setTitle("Show", forState: .Normal)
                }
                
                // hide the view
                view.hidden = !view.hidden
                
                // move the buttons in the section view
                
                // adjust the height of the section view
                supa.frame = CGRectMake(supa.frame.origin.x, supa.frame.origin.y, supa.frame.width, supa.frame.height - viewHeight)
                
                // adjust the y position of each frame
                
                
                // adjust the height of the scroll view
                // nope!
            }
        }
    }
    
    func addItemPressed(sender: UIButton!) {
        for view in sender.superview?.subviews as! [UIView] {
            if(view.restorationIdentifier == "itemsView") {
                // add the item inside of the section
                var sectionItemField = UITextField(frame: CGRectMake(8, 8+30+8+30+8, view.frame.width-16, 30))
                sectionItemField.backgroundColor = UIColor(white: 1, alpha: 1)
                sectionItemField.placeholder = "New item"
                view.addSubview(sectionItemField)
            }
        }
    }
    
    func deletSectionPressed(sender: UIButton!) {
        var supa = sender.superview!
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete List", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            supa.removeFromSuperview()
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
        if segue.identifier == "doneEditing" {
            saveListToCoreData()
            (segue.destinationViewController as! ListDetailViewController).objectID = objectID
            (segue.destinationViewController as! ListDetailViewController).detailList = true
        }
        if segue.identifier == "showTable" {
            if(newList) {
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
                
            } else {
                let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
                
                let deleteAction = UIAlertAction(title: "Cancel Changes", style: .Default, handler: {
                    (alert: UIAlertAction!) -> Void in
                    
                    self.performSegueWithIdentifier("showTable", sender: self)
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                    (alert: UIAlertAction!) -> Void in
                })
                
                optionMenu.addAction(deleteAction)
                optionMenu.addAction(cancelAction)
                
                self.presentViewController(optionMenu, animated: true, completion: nil)
            }
            
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
