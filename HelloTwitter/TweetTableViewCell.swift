//
//  TweetTableViewCell.swift
//  HelloTwitter
//
//  Created by Carmen Wick on 10/4/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    layoutMargins = UIEdgeInsetsZero
    preservesSuperviewLayoutMargins = false
  }
}
