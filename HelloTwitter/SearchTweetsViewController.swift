//
//  Created by Carmen Wick on 10/2/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import UIKit
import CoreData

class SearchTweetsViewController: UITableViewController {
  @IBOutlet private weak var searchField: UITextField!
  @IBOutlet private var cancelButton: UIBarButtonItem!
  
  private var previousSearch = ""
  private var dataSource = TweetsDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchField.delegate = self
    initializeSearchResultsView()
    
    navigationItem.rightBarButtonItem = nil
    navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "",
      style: UIBarButtonItemStyle.Plain,
      target: nil,
      action: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let destination = segue.destinationViewController as? TweetDetailsViewController {
      var tweetText = dataSource.tweets[tableView.indexPathForSelectedRow()!.row].text
      destination.tweetText = tweetText
    }
  }
  
  @IBAction private func didCancelSearch(sender: AnyObject) {
    searchField.resignFirstResponder()
    searchField.text = previousSearch
  }
  
  @IBAction private func searchFieldEditingDidEnd(sender: AnyObject) {
    navigationItem.setRightBarButtonItem(nil, animated: false)
  }
  
  @IBAction private func searchFieldEditingDidBegin(sender: AnyObject) {
    // Needed for selectAll to work
    dispatch_after(1, dispatch_get_main_queue(), {
      self.searchField.selectAll(nil) // pass nil to prevent copy/paste menu from coming up
    })
    
    navigationItem.setRightBarButtonItem(cancelButton, animated: true)
    previousSearch = searchField.text
  }
  
  private func initializeSearchResultsView() {
    self.dataSource.loadMostRecentSearchResults()
    tableView.dataSource = self.dataSource
    tableView.tableFooterView = UIView(frame: CGRectZero)
  }
  
  private func performTwitterSearch(query: String) {
    var api = TwitterAPI(
      key: App.defaults.stringForKey("app_key")!,
      secret: App.defaults.stringForKey("app_secret")!)
    
    api.fetchSearchResults(query) { results in
      self.dataSource.tweets = TweetCollection(fromDictionaryArray: results["statuses"] as NSArray)
      self.saveSearchResults(self.dataSource.tweets)
      self.tableView.reloadData()
    }
  }
  
  private func saveSearchResults(tweets: TweetCollection) {
    App.deleteAllObjectsForEntity("SearchResult")
    App.deleteAllObjectsForEntity("Tweet")
    App.deleteAllObjectsForEntity("TwitterUser")
    
    for tweet in tweets {
      App.createManagedObject("SearchResult").setValue(tweet, forKey: "tweet")
    }
    
    App.managedContext.save(nil)
  }
}

// MARK: UITextFieldDelegate
extension SearchTweetsViewController : UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    var trimmedSearchQuery = textField.text
      .stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    
    if countElements(trimmedSearchQuery) > 0 {
      textField.resignFirstResponder()
      performTwitterSearch(searchField.text)
    }
    
    return false
  }
}

// MARK: UITableViewDelegate
extension SearchTweetsViewController : UITableViewDelegate {
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
}

