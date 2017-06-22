//
//  Event.swift
//  MPBLITZ
//
//  Created by Srivinayak Chaitanya Eshwa on 14/05/17.
//  Copyright © 2017 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Event: NSObject {

    let name: String
    let day: Int
    let date: String
    let type: String
    let time: String
    let rulesAndRegulations: [String: String]
    let eventDescription: String
    
    init(value: [String: AnyObject]) {
        
        self.name = value["name"] as! String
        self.day = value["day"] as! Int
        self.date = self.day == 1 ? "7th July, 2017" : "8th July, 2017"
        self.type = value["type"] as! String
        self.time = value["time"] as! String
        self.eventDescription = value["description"] as! String
        
        let rules = value["rulesAndRegulations"] as! [String: String]
        
        
        self.rulesAndRegulations = rules
        
    }
    
}
