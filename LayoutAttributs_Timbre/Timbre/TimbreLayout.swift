//
//  TimbreLayout.swift
//  RWDevCon
//
//  Created by Mic Pringle on 02/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

func degreesToRadians(degrees: Double) -> CGFloat {
  return CGFloat(M_PI * (degrees) / 180.0)
}

class TimbreLayout: UICollectionViewFlowLayout {
 
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
    var layoutAttributes = super.layoutAttributesForElementsInRect(rect) as! [UICollectionViewLayoutAttributes]
    for attributes in layoutAttributes {
      let frame = attributes.frame
      attributes.transform = CGAffineTransformMakeRotation(degreesToRadians(-14))
      attributes.frame = CGRectInset(frame, 12, 0)
    }
    return layoutAttributes
  }
  
}
