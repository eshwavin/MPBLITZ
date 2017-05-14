//
//  SchoolsTableViewController.swift
//  MPBLITZ
//
//  Created by Srivinayak Chaitanya Eshwa on 15/05/17.
//  Copyright © 2017 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

class SchoolsTableViewController: UITableViewController {
    
    let schools = ["School", "School", "School", "School", "School", "School", "School", "School", "School", "School", "School", "School", "School", "School", "School", "School", "School", "School", "School", "School"]
    
    let taglines = ["Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline", "Tagline"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: #imageLiteral(resourceName: "Background2"))
        imageView.frame = self.tableView.frame
        self.tableView.backgroundView = imageView
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = themeColor
        self.navigationController?.navigationBar.barTintColor = themeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.schools.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolsCell", for: indexPath) as! SchoolsTableViewCell

        cell.schoolLabel.text = self.schools[indexPath.row]
        cell.schoolTagLabel.text = self.taglines[indexPath.row]
        cell.schoolImageView.image = UIImage(named: self.schools[indexPath.row].lowercased())
        
        cell.schoolImageView.layer.cornerRadius = cell.schoolImageView.frame.height / 2.0

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
        
        
        (cell as! SchoolsTableViewCell).schoolImageView.image = nil
        (cell as! SchoolsTableViewCell).schoolImageView.image = UIImage(named: self.schools[indexPath.row].lowercased())
        
        
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
