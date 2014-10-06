//
//  Created by Carmen Wick on 10/2/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import UIKit

class SearchTweetsViewController: UITableViewController {
  @IBOutlet private weak var searchField: UITextField!
  @IBOutlet private var cancelButton: UIBarButtonItem!
  
  private var previousSearch = ""
  private var dataSource = TweetsDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchField.delegate = self
    initializeSearchResultsView()
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 40
    
    navigationItem.rightBarButtonItem = nil
    navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "",
      style: UIBarButtonItemStyle.Plain,
      target: nil,
      action: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    var destination = segue.destinationViewController as TweetDetailsViewController
    var tweetText = dataSource.tweets[tableView.indexPathForSelectedRow()!.row].text
    destination.tweetText = tweetText
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
    tableView.dataSource = self.dataSource
    tableView.tableFooterView = UIView(frame: CGRectZero)
  }
  
  private func performTwitterSearch(query: String) {
    var api = TwitterAPI(
      key: "yr40AyjoUvDBlE2apn4dfsBqz",
      secret: "ZLelMvsTfhjOMoeDjy2qouo66HayjIVoXJWgMLUIQtCX7eY33Z")
    
    api.fetchSearchResults(query) { results in
      self.dataSource.tweets = TweetCollection(fromDictionaryArray: results["statuses"] as NSArray)
      self.tableView.reloadData()
    }
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

