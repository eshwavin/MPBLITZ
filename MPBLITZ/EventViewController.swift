//
//  EventViewController.swift
//  MPBLITZ
//
//  Created by Srivinayak Chaitanya Eshwa on 14/05/17.
//  Copyright © 2017 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rulesTextView: UITextView!
    
    var event: Event?
    
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var rulesTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // text color
        self.descriptionTitleLabel.textColor = themeColor
        self.rulesTitleLabel.textColor = themeColor
        
        self.title = self.event?.name

        self.dateLabel.text = self.event?.date
        self.timeLabel.text = self.event?.time
        self.typeLabel.text = self.event?.type
        
        self.descriptionLabel.text = self.event?.eventDescription
        
        var rules = ""
        
        for (_, v) in (self.event?.rulesAndRegulations.sorted(by: {$0.0 < $1.0}))! {
            rules += v + "\n\n"
            
        }
        
        self.rulesTextView.text = rules.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}

