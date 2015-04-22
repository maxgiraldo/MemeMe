//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Maximilian A. Giraldo on 4/12/15.
//  Copyright (c) 2015 Maximilian A. Giraldo. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
  
  var meme: Meme!

  @IBOutlet weak var memeDetailImage: UIImageView!
  @IBOutlet weak var topText: UITextField!
  @IBOutlet weak var bottomText: UITextField!
  
  let memeTextAttributes: [NSString: AnyObject] = [
    NSStrokeColorAttributeName: UIColor.blackColor(),
    NSForegroundColorAttributeName: UIColor(red: CGFloat(1.0), green: CGFloat(1.0), blue: CGFloat(1.0), alpha: CGFloat(1.0)),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : -3.0
  ]
  
  /**
  * Set the default text styles/attributes to passed in textField parameter
  */

  func setDefaultTextAttributes(textField: UITextField) {
    textField.defaultTextAttributes = memeTextAttributes
    textField.textAlignment = NSTextAlignment.Center
  }
  
  override func viewWillAppear(animated: Bool) {
    let splitText = split(meme.text) {$0 == ","}
    let topText: String = splitText[0]
    let bottomText: String = splitText[1]
    
    memeDetailImage.image = meme.image
    memeDetailImage.contentMode = UIViewContentMode.ScaleAspectFit
    
    self.setDefaultTextAttributes(self.topText)
    self.setDefaultTextAttributes(self.bottomText)
    
    self.bottomText.text = bottomText
    self.topText.text = topText
    self.bottomText.enabled = false
    self.topText.enabled = false
  }
}
