//
//  GradientView.swift
//  RWDevCon
//
//  Created by Mic Pringle on 02/03/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
  
  private var colors = [UIColor.clearColor().CGColor!, UIColor.clearColor().CGColor]
  
  @IBInspectable var startColor: UIColor? {
    didSet {
      if let color = startColor {
        swapColorAtIndex(0, withColor: color.CGColor!)
      }
    }
  }
  
  @IBInspectable var endColor: UIColor? {
    didSet {
      if let color = endColor {
        swapColorAtIndex(1, withColor: color.CGColor!)
      }
    }
  }
    
  override class func layerClass() -> AnyClass {
    return CAGradientLayer.self
  }
  
  override func awakeFromNib() {
    prepareView()
  }
  
  override func prepareForInterfaceBuilder() {
    prepareView()
  }
  
  private func prepareView() {
    let layer = self.layer as! CAGradientLayer
    layer.startPoint = CGPoint(x: 0.0, y: 0.5)
    layer.endPoint = CGPoint(x: 1.0, y: 0.5)
  }
  
  private func swapColorAtIndex(index: Int, withColor color: CGColorRef) {
    colors.removeAtIndex(index)
    colors.insert(color, atIndex: index)
    let layer = self.layer as! CAGradientLayer
    layer.colors = colors
  }
  
}
