//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Maximilian A. Giraldo on 3/22/15.
//  Copyright (c) 2015 Maximilian A. Giraldo. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate {

  @IBOutlet weak var topText: UITextField!
  @IBOutlet weak var bottomText: UITextField!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var toolbar: UIToolbar!
  @IBOutlet weak var shareButton: UIBarButtonItem!
  
  let memeTextAttributes: [NSString: AnyObject] = [
    NSStrokeColorAttributeName: UIColor.blackColor(),
    NSForegroundColorAttributeName: UIColor(red: CGFloat(1.0), green: CGFloat(1.0), blue: CGFloat(1.0), alpha: CGFloat(1.0)),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : -3.0
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setDefaultTextAttributes(self.topText, defaultText: "TOP")
    self.setDefaultTextAttributes(self.bottomText, defaultText: "BOTTOM")

    self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
    self.shareButton.enabled = false
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

  /**
  * Set the default text styles/attributes to passed in textField parameter
  */
  
  func setDefaultTextAttributes(textField: UITextField, defaultText: String) {
    textField.text = defaultText
    textField.defaultTextAttributes = memeTextAttributes
    textField.textAlignment = NSTextAlignment.Center
    textField.delegate = self
  }
  
  /**
  * Textfield helper methods
  */
  
  func isLowerCase(char: String) -> Bool {
    return char == char.lowercaseString
  }
  
  /**
  * Textfield delegate methods
  */
  
  func textFieldDidBeginEditing(textField: UITextField) {
    if textField.text == "TOP" || textField.text == "BOTTOM" {
      textField.text = ""
    }
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    if range.length > 0 {
      return true
    } else if self.isLowerCase(string) {
      let currentText = textField.text
      textField.text = currentText + string.uppercaseString
      return false
    } else {
      return true
    }
  }
  
  /**
  * Generate Meme: combine separate text and image into one image file.
  *
  * Using UIGraphicsBeginImageContext to record what is currently in the view.
  * Implements helper functions to show and hide tool and navigation bar items.
  */
  
  func toggleNavigationBar() {
    let shouldHideNavBar = (self.navigationController?.navigationBarHidden == false)
    self.navigationController?.setNavigationBarHidden(shouldHideNavBar, animated: false)
  }
  
  func toggleToolbar() {
    self.toolbar.hidden = (self.toolbar.hidden == false)
  }
  
  func generateMemedImage() -> UIImage {
    self.toggleNavigationBar()
    self.toggleToolbar()
    
    UIGraphicsBeginImageContext(self.view.frame.size)
    self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
    let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    self.toggleToolbar()
    self.toggleNavigationBar()
    
    return memedImage
  }
  
  /**
  * Save Meme: initialize a UIActivityViewController to share the Meme via iOS's default application activities.
  */
  func saveMeme() {
//    let meme = Meme(text: <#String#>, originalImage: <#UIImage#>, meme: <#UIImage#>)
  }
  
  /**
  * Share Meme: initialize a UIActivityViewController to share the Meme via iOS's default application activities.
  */
  
  @IBAction func shareMeme(sender: AnyObject) {
    let memedImage = self.generateMemedImage()
    
    let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
    
    activityViewController.completionWithItemsHandler = {
      (activity: String!, completed: Bool, items: [AnyObject]!, error: NSError!) -> Void in
      if completed {
        self.saveMeme()
        self.dismissViewControllerAnimated(true, completion: nil)
      }
    }
    
    
    self.navigationController!.presentViewController(activityViewController, animated: true, completion: nil)
  }

  // Keyboard notifications
  
  func keyboardWillShow(notification: NSNotification) {
    if self.bottomText.isFirstResponder() {
      self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
  }
  
  func keyboardWillHide(notification: NSNotification) {
    self.view.frame.origin.y += getKeyboardHeight(notification)
  }
  
  func getKeyboardHeight(notification: NSNotification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue // of CGRect
    return keyboardSize.CGRectValue().height
  }
  
  // Event listeners

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
  
  // Select image
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
      imageView.image = image
      self.shareButton.enabled = true
      
      picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
  }
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func takePhoto(sender: AnyObject) {
  }
  
  @IBAction func choosePhoto(sender: AnyObject) {
    let choosePhotoController = UIImagePickerController()
    choosePhotoController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    choosePhotoController.allowsEditing = true
    choosePhotoController.delegate = self
    self.navigationController!.presentViewController(choosePhotoController, animated: true, completion: nil)
  }

}

