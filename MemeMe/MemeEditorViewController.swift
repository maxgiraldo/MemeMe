//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Maximilian A. Giraldo on 3/22/15.
//  Copyright (c) 2015 Maximilian A. Giraldo. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate {
  @IBOutlet weak var topText: UITextField!
  
  let memeTextAttributes: [NSString: AnyObject] = [
    NSStrokeColorAttributeName: UIColor.blackColor(),
    NSForegroundColorAttributeName: UIColor.whiteColor(),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : 2.0
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    self.topText.defaultTextAttributes = memeTextAttributes
    self.topText.delegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.subscribeToKeyboardNotifications()
    self.subscribeToKeyboardWillHideNotifications()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(true)
    self.unsubscribeFromKeyboardNotifications()
    self.unsubscribeToKeyboardWillHideNotifications()
  }
  
  func generateMemedImage() -> UIImage {
    // TODO: Hide toolbar and navbar
    
    UIGraphicsBeginImageContext(self.view.frame.size)
    self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
    let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    // TODO: Show toolbar and navbar
    
    return memedImage
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func keyboardWillShow(notification: NSNotification) {
    self.view.frame.origin.y -= getKeyboardHeight(notification)
  }
  
  func keyboardWillHide(notification: NSNotification) {
    self.view.frame.origin.y += getKeyboardHeight(notification)
  }
  
  func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue // of CGRect
    return keyboardSize.CGRectValue().height
  }

  func subscribeToKeyboardWillHideNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
  }

  func unsubscribeToKeyboardWillHideNotifications() {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
  }

  func subscribeToKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
  }

}

