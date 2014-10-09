//
//  Created by Carmen Wick on 10/5/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import UIKit
import CoreData

class TweetsDataSource : NSObject, UITableViewDataSource {
  var tweets: TweetCollection = []
  
  func loadMostRecentSearchResults() {
    var model = App.managedObjectModel
    var fetchRequest = NSFetchRequest(entityName: "SearchResult")
    fetchRequest.relationshipKeyPathsForPrefetching = ["tweet"]
    fetchRequest.returnsObjectsAsFaults = false
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rank", ascending: true)]
    
    var searchResults = App.managedContext.executeFetchRequest(fetchRequest, error: nil) as [NSManagedObject]
    var tweets = searchResults.map({ (result) -> (Tweet) in result.valueForKey("tweet") as Tweet })
    
    self.tweets = TweetCollection(elements: tweets)
  }
  
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