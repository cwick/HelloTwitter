//
//  Created by Carmen Wick on 10/5/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import UIKit

class TweetsDataSource : NSObject, UITableViewDataSource {
  var tweets: TweetCollection = []
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    var cell = tableView.dequeueReusableCellWithIdentifier("Tweet Cell",
      forIndexPath: indexPath) as TweetTableViewCell
    
    var tweet = tweets[indexPath.row]
    
    cell.tweetTextView.text = tweet.text
    cell.profileImage.sd_setImageWithURL(NSURL(string: tweet.user.profileImageURL))
    cell.userNameLabel.text = tweet.user.name
    
    return cell
  }
}