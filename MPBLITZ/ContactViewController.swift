//
//  ContactViewController.swift
//  MPBLITZ
//
//  Created by Srivinayak Chaitanya Eshwa on 07/06/17.
//  Copyright © 2017 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var queriesLabel: UILabel!
    @IBOutlet var detailsButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = themeColor
        self.navigationController?.navigationBar.barTintColor = themeColor
        self.navigationController?.navigationBar.tintColor = UIColor.white

        
        self.queriesLabel.textColor = themeColor
        
        for button in self.detailsButtons {
            button.setTitleColor(themeColor, for: .normal)
        }
        
        
    }
    
    @IBAction func call(_ sender: UIButton) {
        
        if let contact = sender.titleLabel?.text {
            
            let URL = "telprompt://" + contact
            
            if let url = NSURL(string: URL) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
            
        }
            
        else {
            //error message
        }
        
        
        
    }
    
    // MARK: - Mail controller
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    

    
    @IBAction func email(_ sender: UIButton) {
        
        if let email = sender.titleLabel?.text {
            
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([email])
                
                self.present(mail, animated: true)
            }
            
        }
        
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
