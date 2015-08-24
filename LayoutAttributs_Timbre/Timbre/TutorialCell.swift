//
//  TutorialCell.swift
//  RWDevCon
//
//  Created by Mic Pringle on 02/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class TutorialCell: UICollectionViewCell {
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var timeAndRoomLabel: UILabel!
  @IBOutlet private weak var speakerLabel: UILabel!
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var imageViewCenterYLayoutConstraint: NSLayoutConstraint!
  
  var parallaxOffset: CGFloat = 0 {
    didSet {
      imageViewCenterYLayoutConstraint.constant = parallaxOffset
    }
  }
  
  var tutorial: Tutorial? {
    didSet {
      if let tutorial = tutorial {
        titleLabel.text = tutorial.title
        timeAndRoomLabel.text = tutorial.timeAndRoom
        speakerLabel.text = tutorial.speaker
        imageView.image = tutorial.backgroundImage
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    clipsToBounds = false
  }

  override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes!) {
    super.applyLayoutAttributes(layoutAttributes)
    imageView.transform = CGAffineTransformMakeRotation(degreesToRadians(14))
  }
  
  func updateParallaxOffset(collectionViewBounds bounds: CGRect) {
    let center = CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds))
    let offsetFromCenter = CGPoint(x: center.x - self.center.x, y: center.y - self.center.y)
    let maxVerticalOffset = (CGRectGetHeight(bounds) / 2) + (CGRectGetHeight(self.bounds) / 2)
    let scaleFactor = 40 / maxVerticalOffset
    parallaxOffset = -offsetFromCenter.y * scaleFactor
  }
  
}
