//
//  Meme.swift
//  MemeMe
//
//  Created by Maximilian A. Giraldo on 3/22/15.
//  Copyright (c) 2015 Maximilian A. Giraldo. All rights reserved.
//

import Foundation
import UIKit

class Meme {
  var text: String!
  let image, meme: UIImage!
  
  init(text: String, originalImage: UIImage, meme: UIImage) {
    self.text = text
    self.image = originalImage
    self.meme = meme
  }
}