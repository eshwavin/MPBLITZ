//
//  DataManager.swift
//  MPBLITZ
//
//  Created by Srivinayak Chaitanya Eshwa on 14/05/17.
//  Copyright © 2017 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DataManager: NSObject {
    
    
    
    func getEvents(completion: @escaping (_ snapshot: FIRDataSnapshot) -> Void, inCaseOfError: @escaping (_ error: Error) -> Void){
        
        
        FIRDatabase.database().reference().child("events").observe(.value, with: { (snapshot) in
            completion(snapshot)
        }, withCancel: inCaseOfError)
        
    }
    
    func isSchoolsUpdated() -> Bool {
        
        var returnVal = true
        FIRDatabase.database().reference().child("schools").child("updated").observe(.value, with: { (snapshot) in
            
            if !(snapshot.value is NSNull) {
                
                let value = snapshot.value! as! String
                
                if value != "Y" {
                    returnVal = false
                }
                
            }
            
        })
        return returnVal
        
    }
    
    func getSchools(completion: @escaping (_ snapshot: FIRDataSnapshot) -> Void, inCaseOfError: @escaping (_ error: Error) -> Void) {
        
        if !self.isSchoolsUpdated() {
            return
        }
        
        FIRDatabase.database().reference().child("schools").observe(.value, with: { (snapshot) in
            
            completion(snapshot)
            
        }, withCancel: inCaseOfError)
        
    }

}
