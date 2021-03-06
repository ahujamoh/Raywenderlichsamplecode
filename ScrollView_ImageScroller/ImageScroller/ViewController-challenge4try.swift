//
//  ViewController.swift
//  ImageScroller
//
//  Created by Greg Heo on 2014-12-18.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var imageView: UIImageView!
  var scrollView: UIScrollView!
  var originLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    imageView = UIImageView(image: UIImage(named: "zombies.jpg"))

    scrollView = UIScrollView(frame: view.bounds)
    scrollView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
    scrollView.backgroundColor = UIColor.darkGrayColor()
    scrollView.contentSize = imageView.bounds.size

    scrollView.addSubview(imageView)
    view.addSubview(scrollView)

    originLabel = UILabel(frame: CGRect(x: 20, y: 30, width: 0, height: 0))
    originLabel.backgroundColor = UIColor.blackColor()
    originLabel.textColor = UIColor.whiteColor()
    originLabel.numberOfLines = 0
    view.addSubview(originLabel)

    scrollView.delegate = self

    scrollView.minimumZoomScale = 0.1
    scrollView.zoomScale = 1.0
    scrollView.maximumZoomScale = 3.0

    setZoomScales(scrollView.bounds.size)
//    scrollView.zoomScale = scrollView.minimumZoomScale
    recenterImage()

    let lineWidth: CGFloat = 2.0
    let verticalLine = UIView(frame: CGRect(x: CGRectGetMidX(view.bounds), y: 0, width: lineWidth, height: CGRectGetHeight(view.bounds)))
    verticalLine.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.5)
    verticalLine.autoresizingMask = .FlexibleHeight | .FlexibleLeftMargin | .FlexibleRightMargin
    view.addSubview(verticalLine)

    let horizontalLine = UIView(frame: CGRect(x: 0, y: CGRectGetMidY(view.bounds), width: CGRectGetWidth(view.bounds), height: lineWidth))
    horizontalLine.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.5)
    horizontalLine.autoresizingMask = .FlexibleWidth | .FlexibleTopMargin | .FlexibleBottomMargin
    view.addSubview(horizontalLine)
  }

  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    let zoomScale = scrollView.zoomScale
    let centerPoint = CGPoint(x: scrollView.contentOffset.x + CGRectGetWidth(scrollView.bounds) / 2,
      y: scrollView.contentOffset.y + CGRectGetHeight(scrollView.bounds) / 2)

    coordinator.animateAlongsideTransition({ (context) -> Void in
      self.setZoomScales(size)
      self.scrollView.zoomScale = zoomScale
      self.scrollView.contentOffset = CGPoint(x: centerPoint.x - size.width / 2,
        y: centerPoint.y - size.height / 2)
    }, completion: { (context) -> Void in
    })
  }

  func setZoomScales(scrollViewSize: CGSize) {
    let imageSize = imageView.bounds.size

    let widthScale = scrollViewSize.width / imageSize.width
    let heightScale = scrollViewSize.height / imageSize.height
    let minScale = min(widthScale, heightScale)

    scrollView.minimumZoomScale = minScale
    scrollView.maximumZoomScale = 3.0
    scrollView.zoomScale = scrollView.minimumZoomScale
  }

  func recenterImage() {
    let scrollViewSize = scrollView.bounds.size
    let imageSize = imageView.frame.size

    let horizontalSpace: CGFloat = {
      if imageSize.width < scrollViewSize.width {
        return (scrollViewSize.width - imageSize.width) / 2
      } else {
        return 0
      }
    }()
    let verticalSpace: CGFloat = {
      if imageSize.height < scrollViewSize.height {
        return (scrollViewSize.height - imageSize.height) / 2
      } else {
        return 0
      }
    }()

    scrollView.contentInset = UIEdgeInsets(top: verticalSpace, left: horizontalSpace, bottom: verticalSpace, right: horizontalSpace)
  }

  override func viewWillLayoutSubviews() {
    recenterImage()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func updateLabel() {
    originLabel.text = "Offset: \(scrollView.contentOffset)\nZoom scale: \(scrollView.zoomScale)"
    originLabel.sizeToFit()
  }
}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    updateLabel()
  }

  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return imageView
  }

  func scrollViewDidZoom(scrollView: UIScrollView) {
    recenterImage()
    updateLabel()
  }
}
