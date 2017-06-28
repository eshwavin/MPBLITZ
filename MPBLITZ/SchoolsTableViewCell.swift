//
//  SchoolsTableViewCell.swift
//  MPBLITZ
//
//  Created by Srivinayak Chaitanya Eshwa on 15/05/17.
//  Copyright © 2017 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

class SchoolsTableViewCell: UITableViewCell {

    @IBOutlet weak var schoolImageView: UIImageView!
    @IBOutlet weak var schoolLabel: UILabel!
    
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        // gradient layer for cell
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.gradientLayer.frame = self.bounds
        let color1 = UIColor(white: 1.0, alpha: 0.2).cgColor as CGColor
        let color2 = UIColor(white: 1.0, alpha: 0.1).cgColor as CGColor
        let color3 = UIColor.clear.cgColor as CGColor
        let color4 = UIColor(white: 0.0, alpha: 0.1).cgColor as CGColor
        self.gradientLayer.colors = [color1, color2, color3, color4]
        self.gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
        self.layer.insertSublayer(self.gradientLayer, at: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // gradient layer for cell
        self.gradientLayer.frame = self.bounds
        let color1 = UIColor(white: 1.0, alpha: 0.2).cgColor as CGColor
        let color2 = UIColor(white: 1.0, alpha: 0.1).cgColor as CGColor
        let color3 = UIColor.clear.cgColor as CGColor
        let color4 = UIColor(white: 0.0, alpha: 0.1).cgColor as CGColor
        self.gradientLayer.colors = [color1, color2, color3, color4]
        self.gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
        self.layer.insertSublayer(self.gradientLayer, at: 0)
    }

}
