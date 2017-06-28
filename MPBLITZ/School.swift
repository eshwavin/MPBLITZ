//
//  School.swift
//  MPBLITZ
//
//  Created by Srivinayak Chaitanya Eshwa on 22/06/17.
//  Copyright © 2017 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import RealmSwift

class School: Object {
    
    dynamic var name: String = ""
    dynamic var imageName: String = ""
    dynamic var image: NSData? = nil
    
    override static func primaryKey() -> String {
        return "name"
    }
    
}
