//
//  CourseCellTableViewCell.swift
//  class_09_22
//
//  Created by Brittany Kos on 9/22/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit

class CourseCellTableViewCell: UITableViewCell {
    
    
    var name: String = "" {
        didSet {
            if (name != oldValue) {
                nameLabel.text = name
            }
        }
    }
    var credits: String = "" {
        didSet {
            if (credits != oldValue) {
                creditsLabel.text = credits
            }
        }
    }
    var grade: String = "" {
        didSet {
            if (grade != oldValue) {
                gradeLabel.text = grade
            }
        }
    }
    var enrolled: String = "" {
        didSet {
            if (enrolled != oldValue) {
                enrolledLabel.text = enrolled
            }
        }
    }
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var creditsLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
    @IBOutlet var enrolledLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
