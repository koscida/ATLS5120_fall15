//
//  CourseListViewController.swift
//  class_09_22
//
//  Created by Brittany Kos on 9/22/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit

class CourseListViewController: UITableViewController {
    
    var newCourseName: String = ""
    var newCourseEnrolled: Bool = false
    var newCourseCredits: Float = 0.0
    var newCourseLetter: String = ""
    var newCourseNumeric: Float = 0.0
    
    var courses = [
        ["Mobile App Development", true, 3.0, "A-", 3.7],
        ["Course Name", false, 3.0, "B-", 2.7]
    ]
    let simpleTableIdentifier = "courseCell"
    
    let nf = NSNumberFormatter()
    
    var totalCredits: Float = 0.0
    var totalCreditGrades: Float = 0.0
    
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        nf.numberStyle = .DecimalStyle
        updateGPA()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as? UITableViewCell
        
        //if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: simpleTableIdentifier)
        //}
        
        cell!.textLabel!.text = courses[indexPath.row][0] as? String
        cell!.detailTextLabel?.text = courses[indexPath.row][3] as? String

        return cell!
    }

    
    // MARK: - Navigation

    @IBAction func cancel(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        var courseDetailVC = segue.sourceViewController as! CourseDetailViewController
        
        newCourseName = courseDetailVC.name
        newCourseEnrolled = courseDetailVC.enrol
        newCourseCredits = courseDetailVC.cred
        newCourseLetter = courseDetailVC.lett
        newCourseNumeric = courseDetailVC.num
        
        courses.append([newCourseName, newCourseEnrolled, newCourseCredits, newCourseLetter, newCourseNumeric])
        
        self.tableView.reloadData()
        updateGPA()
    }
    
    
    func updateGPA() {
        
        for(var i=0; i<courses.count; i++) {
            totalCredits += courses[i][2] as! Float
            totalCreditGrades += ((courses[i][2] as! Float) * (courses[i][4] as! Float))
        }
        
        creditsLabel.text = nf.stringFromNumber(totalCredits)
        gpaLabel.text = nf.stringFromNumber((totalCreditGrades / totalCredits))

    }


}
