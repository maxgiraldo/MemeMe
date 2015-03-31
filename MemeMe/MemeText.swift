//
//  MemeText.swift
//  MemeMe
//
//  Created by Maximilian A. Giraldo on 3/29/15.
//  Copyright (c) 2015 Maximilian A. Giraldo. All rights reserved.
//

import Foundation
import UIKit

class MemeText {
  
  let attributes: [NSString: AnyObject] = [
    NSStrokeColorAttributeName: UIColor.blackColor(),
    NSForegroundColorAttributeName: UIColor(red: CGFloat(1.0), green: CGFloat(1.0), blue: CGFloat(1.0), alpha: CGFloat(1.0)),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : -3.0
  ]
  
  init() {
  }
}