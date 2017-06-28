//
//  ScheduleCollectionViewCell.swift
//  MPBLITZ
//
//  Created by Srivinayak Chaitanya Eshwa on 14/05/17.
//  Copyright © 2017 Srivinayak Chaitanya Eshwa. All rights reserved.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var imageCoverView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var event: Event? {
        didSet {
            if let event = event {
                self.imageView.image = UIImage(named: event.imageName.lowercased())
                self.titleLabel.text = event.name
                self.descriptionLabel.text = event.eventDescription
            }
        }
    }
        
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let featuredHeight = ScheduleLayoutConstants.cell.featuredHeight
        let standardHeight = ScheduleLayoutConstants.cell.standardHeight
        
        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.2
        let maxAlpha: CGFloat = 0.75
        
        self.imageCoverView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        titleLabel.transform = CGAffineTransform.init(scaleX: scale, y: scale)
        
        self.descriptionLabel.alpha = delta
        
    }
    
}
