//
//  DeveloperViewController.swift
//  MPBLITZ
//
//  Created by Srivinayak Chaitanya Eshwa on 15/05/17.
//  Copyright © 2017 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

class DeveloperViewController: UIViewController {

    @IBOutlet weak var devImageView: UIImageView!
    @IBOutlet weak var desImageView: UIImageView!
    @IBOutlet weak var devNameLabel: UILabel!
    @IBOutlet weak var desNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.devNameLabel.textColor = themeColor
        self.desNameLabel.textColor = themeColor
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = themeColor
        self.navigationController?.navigationBar.barTintColor = themeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.devImageView.layer.cornerRadius = self.devImageView.frame.height / 2.0
        self.desImageView.layer.cornerRadius = self.desImageView.frame.height / 2.0
        
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
