//
//  Created by Carmen Wick on 10/5/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
  @IBOutlet weak private var tweetLabel: UILabel!
  var tweetText = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "",
      style: UIBarButtonItemStyle.Plain,
      target: nil,
      action: nil)
    
    tweetLabel.text = tweetText
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "search_again" {
      var controller = segue.destinationViewController as SearchTweetsViewController
      controller.navigationItem.leftBarButtonItem = nil
    }
  }
}
