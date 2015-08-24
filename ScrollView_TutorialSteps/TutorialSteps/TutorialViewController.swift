/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class TutorialViewController: UIViewController {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var pageControl: UIPageControl!

  var pages = [TutorialStepViewController]()

  override func viewDidLoad() {
    super.viewDidLoad()

    scrollView.pagingEnabled = true
    
    let page1 = createAndAddTutorialStep("bg_1", iconImageName: "icon_1", text: "PetShare is a pet photo sharing community.")
    let page2 = createAndAddTutorialStep("bg_2", iconImageName: "icon_2", text: "Take pictures of your pet, and add filters or clipart to help them shine.")
    let page3 = createAndAddTutorialStep("bg_3", iconImageName: "icon_3", text: "Share your photos via Facebook, email, Twitter, or instant message.")
    let page4 = createAndAddTutorialStep("bg_4", iconImageName: "icon_4", text: "Rate other photos, give hearts, and follow pets you adore!")
    let page5 = createAndAddTutorialStep("bg_5", iconImageName: "icon_5", text: "Set up a profile for your pet, show past photos, and let fans follow.")

    pages = [page1, page2, page3, page4, page5]

    pageControl.numberOfPages = pages.count

    let views = ["view": view, "page1": page1.view, "page2": page2.view, "page3": page3.view, "page4": page4.view, "page5": page5.view]
    let metrics = ["edgeMargin": 10, "betweenMargin": 20]

    let verticalConstraints =
      NSLayoutConstraint.constraintsWithVisualFormat(
        "V:|[page1(==view)]|", options: nil, metrics: nil, views: views)
    NSLayoutConstraint.activateConstraints(verticalConstraints)

    let horizontalConstraints =
      NSLayoutConstraint.constraintsWithVisualFormat(
        "H:|-edgeMargin-[page1(==view)]-betweenMargin-[page2(==view)]-betweenMargin-[page3(==view)]-betweenMargin-[page4(==view)]-betweenMargin-[page5(==view)]-edgeMargin-|", options: .AlignAllTop | .AlignAllBottom, metrics: metrics, views: views)
    NSLayoutConstraint.activateConstraints(horizontalConstraints)
  }

  @IBAction func pageChanged(sender: UIPageControl) {
    let currentPage = sender.currentPage
    let pageWidth = CGRectGetWidth(scrollView.bounds)
    let targetContentOffsetX = CGFloat(currentPage) * pageWidth

    UIView.animateWithDuration(0.33, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
      self.scrollView.contentOffset.x = targetContentOffsetX
    }, completion: nil)
  }

  private func createAndAddTutorialStep(backgroundImageName: String, iconImageName: String, text: String) -> TutorialStepViewController {
    let tutorialStep = storyboard!.instantiateViewControllerWithIdentifier("TutorialStepViewController") as! TutorialStepViewController
    tutorialStep.view.setTranslatesAutoresizingMaskIntoConstraints(false)
    tutorialStep.backgroundImage = UIImage(named: backgroundImageName)
    tutorialStep.iconImage = UIImage(named: iconImageName)
    tutorialStep.text = text

    scrollView.addSubview(tutorialStep.view)

    addChildViewController(tutorialStep)
    tutorialStep.didMoveToParentViewController(self)

    return tutorialStep
  }
}

extension TutorialViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    let pageWidth = CGRectGetWidth(scrollView.bounds)
    let pageFraction = scrollView.contentOffset.x / pageWidth

    pageControl.currentPage = Int(round(pageFraction))
  }
}
