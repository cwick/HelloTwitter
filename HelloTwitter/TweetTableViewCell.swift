//
//  Created by Carmen Wick on 10/4/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var tweetTextView: UITextView!
  @IBOutlet weak var userNameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    layoutMargins = UIEdgeInsetsZero
    preservesSuperviewLayoutMargins = false
    profileImage.layer.cornerRadius = 4
    profileImage.layer.masksToBounds = true
    tweetTextView.textContainerInset = UIEdgeInsetsZero
    tweetTextView.contentInset = UIEdgeInsetsZero
  }
}
