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
      forIndexPath: indexPath) as UITableViewCell
    
    var text = (tweets[indexPath.row] as NSDictionary)["text"] as String
    cell.textLabel?.text = text
    
    return cell
  }
}