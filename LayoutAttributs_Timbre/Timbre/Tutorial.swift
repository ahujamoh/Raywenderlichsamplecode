//
//  Tutorial.swift
//  RWDevCon
//
//  Created by Mic Pringle on 27/02/2015.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class Tutorial: Session {
  
  class func allTutorials() -> [Tutorial] {
    var tutorials = [Tutorial]()
    if let URL = NSBundle.mainBundle().URLForResource("Tutorials", withExtension: "plist") {
      if let tutorialsFromPlist = NSArray(contentsOfURL: URL) {
        for dictionary in tutorialsFromPlist {
          let tutorial = Tutorial(dictionary: dictionary as! NSDictionary)
          tutorials.append(tutorial)
        }
      }
    }
    return tutorials
  }
  
}