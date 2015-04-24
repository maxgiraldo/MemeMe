//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Maximilian A. Giraldo on 4/4/15.
//  Copyright (c) 2015 Maximilian A. Giraldo. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "MemeCollectionViewCell"
private let detailIdentifier = "MemeDetailViewController"

class MemeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var memes = [Meme]()
  
  override func viewDidLoad() {
    self.memes = Meme.all()
    if self.memes.count == 0 {
      self.performSegueWithIdentifier("newMeme", sender: self)
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    self.memes = Meme.all()
    self.collectionView!.delegate = self
    self.collectionView!.reloadData()
  }

  @IBOutlet weak var newMemeButton: UIBarButtonItem!
  
  @IBAction func newMeme(sender: AnyObject) {
    self.performSegueWithIdentifier("newMeme", sender: self)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let widthOfFrame = self.collectionView!.frame.width

    let sizeOfCell = ((widthOfFrame / 4) - 1.0) as CGFloat
    
    return CGSize(width: sizeOfCell, height: sizeOfCell)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    let spacing = CGFloat(0.0)
    
    return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return CGFloat(1.0)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return CGFloat(1.0)
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.memes.count
  }
  
  let memeTextAttributes: [NSString: AnyObject] = [
    NSStrokeColorAttributeName: UIColor.blackColor(),
    NSForegroundColorAttributeName: UIColor(red: CGFloat(1.0), green: CGFloat(1.0), blue: CGFloat(1.0), alpha: CGFloat(1.0)),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : -3.0
  ]
  
  /**
  * Set the default text styles/attributes to passed in textField parameter
  */
  
  func setDefaultAttributesForTextField(textField: UITextField) {
    textField.defaultTextAttributes = memeTextAttributes
    textField.textAlignment = NSTextAlignment.Center
  }

  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
      let meme = memes[indexPath.item]
    
      let splitText = split(meme.text) {$0 == ","}
      let topText: String = splitText[0]
      let bottomText: String = splitText[1]
    
      cell.topTextField.text = topText
      cell.bottomTextField.text = bottomText
      self.setDefaultAttributesForTextField(cell.topTextField)
      self.setDefaultAttributesForTextField(cell.bottomTextField)
      cell.topTextField.enabled = false
      cell.bottomTextField.enabled = false
      cell.memeImage.image = meme.image
    
      return cell
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let detailController = self.storyboard!.instantiateViewControllerWithIdentifier(detailIdentifier) as! MemeDetailViewController
    detailController.meme = self.memes[indexPath.row]
    self.navigationController!.pushViewController(detailController, animated: true)
  }

}
