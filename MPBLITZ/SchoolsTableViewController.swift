//
//  SchoolsTableViewController.swift
//  MPBLITZ
//
//  Created by Srivinayak Chaitanya Eshwa on 15/05/17.
//  Copyright © 2017 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseDatabase
import FirebaseStorage

class SchoolsTableViewController: UITableViewController {
    
    var schools: [School] = []
    
    var messageLabel: UILabel = UILabel()
    var loaded = false
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "Background2"))

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.imageView.frame = self.tableView.frame
        self.tableView.backgroundView = self.imageView
        
        
        self.messageLabel.textColor = UIColor.white
        self.messageLabel.numberOfLines = 0
        self.messageLabel.textAlignment = .center
        self.messageLabel.font = UIFont(name: "Avenir Medium", size: 20)
        self.messageLabel.sizeToFit()
        self.messageLabel.backgroundColor = UIColor.clear
        
        self.messageLabel.alpha = 0.0
        self.imageView.addSubview(messageLabel)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = themeColor
        self.navigationController?.navigationBar.barTintColor = themeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        // reachability
        
        NotificationCenter.default.addObserver(self, selector: #selector(SchoolsTableViewController.reachabilityChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        self.reachabilityChanged()

        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.messageLabel.frame = CGRect(x: 0.0, y: 0.0, width: self.tableView.frame.width, height: self.tableView.frame.height)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if self.schools.count == 0 {
            self.messageLabel.text = self.loaded ? "School list has not been compiled yet" : "Loading..."
            
            
            self.messageLabel.alpha = 1.0
            
            return 0

        }
        else {
            self.messageLabel.alpha = 0.0
            return 1
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.schools.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolsCell", for: indexPath) as! SchoolsTableViewCell

        cell.schoolLabel.text = self.schools[indexPath.row].name
        cell.schoolTagLabel.text = self.schools[indexPath.row].tagline
        
        cell.schoolImageView.image = nil
        
        if let data = self.schools[indexPath.row].image  {
            cell.schoolImageView.image = UIImage(data: data as Data)
        }
        
        cell.schoolImageView.layer.cornerRadius = cell.schoolImageView.frame.height / 2.0
        cell.schoolImageView.clipsToBounds = true

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(translationX: 0, y: tableView.rowHeight)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 10, height: 10)
        cell.alpha = 0
        
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.5)
        cell.transform = CGAffineTransform(translationX: 0, y: 0)
        cell.alpha = 1
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        UIView.commitAnimations()
        
    }
    
    // MARK: - Reachability
    
    func reachabilityChanged() {
        if reachabilityStatus == NOACCESS {
            DispatchQueue.main.async {
                self.present(noInternetAccessAlert(), animated: true, completion: nil)
            }
        }
        else {
            
            if realm.objects(School.self).count == 0 {
                DataManager().getSchools(completion: completion, inCaseOfError: inCaseOfError)
            }
            else {
                DataManager().isSchoolsUpdated(completion: completion, ifNot: internalDatabaseLoad, inCaseOfError: inCaseOfError)
            }
            
            
        }
    }

    
    // MARK: - Get Data
    
    func internalDatabaseLoad() {
        
        self.schools = []
        
        self.messageLabel.alpha = 0.0
        
        for object in realm.objects(School.self) {
            self.schools.append(object)
        }
        self.tableView.reloadData()
        
    }
    
    func completion(snaphshot: FIRDataSnapshot) {
        
        self.schools = []
        
        try! realm.write {
            realm.delete(realm.objects(School.self))
        }
        
        if !(snaphshot.value is NSNull) {
            
            let value = snaphshot.value as! [String: AnyObject]
            
            for (_, data) in value {
                let dataDict = data as! [String : String]
                
                let school = School()
                
                school.name = dataDict["name"]!
                school.tagline = dataDict["tagline"]!
                school.imageName = dataDict["imageName"]!
                
                if dataDict["imageUpdated"]! == "Y" {
                    let storageReference = FIRStorage.storage().reference(forURL: "gs://mpblitz-a1d75.appspot.com")
                    storageReference.child("schools").child(school.imageName).data(withMaxSize: 1024 * 1024, completion: { (data, error) in
                        
                        if error == nil {
                            school.image = data! as NSData
                            
                            try! realm.write {
                                realm.add(school, update: true)
                                self.schools.append(school)
                                self.loaded = true
                                self.tableView.reloadData()
                            }
                            
                        }
                        else {
                            print(error?.localizedDescription)
                        }
                        
                    })
                }
                
            }
            
        }
        
        
    }
    
    func inCaseOfError(error: Error) {
        self.present(showAlert("Oops", message: "There was some error loading the data"), animated: true, completion: nil)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
