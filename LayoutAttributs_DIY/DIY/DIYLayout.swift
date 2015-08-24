//
//  DIYLayout.swift
//  DIY
//
//  Created by Mic Pringle on 10/03/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import UIKit

class DIYLayout: UICollectionViewFlowLayout {
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
    let layoutAttributes = super.layoutAttributesForElementsInRect(rect) as! [UICollectionViewLayoutAttributes]
    let insets = collectionView!.contentInset
    let offset = collectionView!.contentOffset
    let minY = -insets.top
    if (offset.y < minY) {
      let deltaY = fabs(offset.y - minY)
      for attributes in layoutAttributes {
        if let elementKind = attributes.representedElementKind {
          if elementKind == UICollectionElementKindSectionHeader {
            var frame = attributes.frame
            frame.size.height = max(minY, headerReferenceSize.height + deltaY)
            frame.origin.y = CGRectGetMinY(frame) - deltaY
            attributes.frame = frame
          }
        }
      }
    }
    return layoutAttributes
  }
  
  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    return true
  }
  
}
