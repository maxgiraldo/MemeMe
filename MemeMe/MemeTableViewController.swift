//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Maximilian A. Giraldo on 4/4/15.
//  Copyright (c) 2015 Maximilian A. Giraldo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeTableViewCell"
private let detailIdentifier = "MemeDetailViewController"

class MemeTableViewController: UITableViewController, UITableViewDataSource {
  
  var memes = [Meme]()

  @IBAction func newMeme(sender: AnyObject) {
    self.performSegueWithIdentifier("newMeme", sender: self)
  }
  
  override func viewWillAppear(animated: Bool) {
    self.memes = Meme.all()
    self.tableView!.reloadData()
  }

  override func viewDidLoad() {
      super.viewDidLoad()
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.memes.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! MemeTableViewCell
    let meme = self.memes[indexPath.row]
    cell.tableImageView.image = meme.meme
    cell.tableLabel.text = meme.text
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let detailController = self.storyboard!.instantiateViewControllerWithIdentifier(detailIdentifier) as! MemeDetailViewController
    detailController.meme = self.memes[indexPath.row]
    self.navigationController!.pushViewController(detailController, animated: true)
  }

}
