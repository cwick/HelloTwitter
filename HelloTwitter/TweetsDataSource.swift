//
//  Created by Carmen Wick on 10/5/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import UIKit

class TweetsDataSource : NSObject, UITableViewDataSource {
  var tweets: NSArray = []
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
  
  func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    var cell = tableView.dequeueReusableCellWithIdentifier("Tweet Cell",
      forIndexPath: indexPath) as TweetTableViewCell
    
    var tweet = (tweets[indexPath.row] as NSDictionary)
    var text = tweet["text"] as String
    var profileImageURL = (tweet["user"] as NSDictionary)["profile_image_url_https"] as String
    
    profileImageURL = profileImageURL.stringByReplacingOccurrencesOfString("_normal.jpeg",
      withString: "_bigger.jpeg",
//      withString: ".jpeg",
      options: NSStringCompareOptions.LiteralSearch,
      range: nil)
    
//    cell.textLabel!.text = text
//    
    cell.profileImage.sd_setImageWithURL(NSURL(string: profileImageURL), completed: { (image, error, cacheType, url) -> Void in
//      cell.layoutSubviews()
    })
    
    return cell
  }
}