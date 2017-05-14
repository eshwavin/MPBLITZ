//
//  ScheduleViewController.swift
//  MPBLITZ
//
//  Created by Srivinayak Chaitanya Eshwa on 07/05/17.
//  Copyright © 2017 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit
import FirebaseDatabase

var selectedIndex: Int = 0

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    let titles = ["All Events", "Day 1", "Day 2", "On Stage", "Off Stage", "Day 1 - On Stage", "Day 1 - Off Stage", "Day 2 - On Stage", "Day 2 - Off Stage"]
    
    var events: [Event] = []
    var selectedEvents: [Event] = []
    @IBOutlet weak var sortEventsButton: UIButton!
    
    // MARK: - View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = themeColor
        self.navigationController?.navigationBar.barTintColor = themeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.tabBarController?.tabBar.tintColor = themeColor
        
        
//        self.backgroundImageView.layer.insertSublayer(getLayer(with: self.backgroundImageView.frame), at: 0)

        self.backgroundImageView.backgroundColor = UIColor.black
        
        DataManager().getEvents(completion: getData, inCaseOfError: inCaseOfError)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.sortEventsButton.setTitle(self.titles[selectedIndex], for: UIControlState.normal)
        
        self.sortSelectedEvents()
        
    }
    
    // MARK: - Data
    
    func getData(_ snapshot: FIRDataSnapshot) -> Void {
        
        self.events = []
        
        if !(snapshot.value is NSNull) {
            let value = snapshot.value! as! [String: AnyObject]
            
            for event in value {
                
                self.events.append(Event(value: event.value as! [String: AnyObject]))
                
            }
            
        }
        
        self.sortSelectedEvents()
        
    }
    
    
    
    func inCaseOfError(_ error: Error) -> Void {
        print(error.localizedDescription)
    }
    
    // MARK: - Events
    
    func sortSelectedEvents() {
        
        self.selectedEvents = []
        
        switch selectedIndex {
        case 1:
            self.selectedEvents = self.events.filter({ (event) -> Bool in
                return event.day == 1
            })
            
        case 2:
            self.selectedEvents = self.events.filter({ (event) -> Bool in
                return event.day == 2
            })
            
        case 3:
            self.selectedEvents = self.events.filter({ (event) -> Bool in
                return event.type == "On Stage"
            })
            
        case 4:
            self.selectedEvents = self.events.filter({ (event) -> Bool in
                return event.type == "Off Stage"
            })
        
        case 5:
            self.selectedEvents = self.events.filter({ (event) -> Bool in
                return event.type == "On Stage" && event.day == 1
            })
            
        case 6:
            self.selectedEvents = self.events.filter({ (event) -> Bool in
                return event.type == "Off Stage" && event.day == 1
            })
            
        case 7:
            self.selectedEvents = self.events.filter({ (event) -> Bool in
                return event.type == "On Stage" && event.day == 2
            })
            
        case 8:
            self.selectedEvents = self.events.filter({ (event) -> Bool in
                return event.type == "Off Stage" && event.day == 2
            })
            
        default:
            self.selectedEvents = self.events
        }
        
        self.collectionView.reloadData()
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sortSegue" {
            let destination = segue.destination as! ScheduleTableViewController
            destination.snapshot = self.view.snapshotView(afterScreenUpdates: true)
        }
        else if segue.identifier == "showEvent" {
            let destination = segue.destination as! EventViewController
            destination.event = self.selectedEvents[(sender as! Int)]
        }
        
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }

}

extension ScheduleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! ScheduleCollectionViewCell
        cell.event = self.selectedEvents[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showEvent", sender: indexPath.item)
        
    }
    
    
}

