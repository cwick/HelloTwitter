//
//  Created by Carmen Wick on 10/2/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import UIKit

class SearchTweetsViewController: UITableViewController {
  @IBOutlet private weak var searchField: UITextField!
  @IBOutlet private var cancelButton: UIBarButtonItem!
  @IBOutlet weak var searchResults: UITableView!
  
  private var previousSearch = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchField.delegate = self
    
    navigationItem.rightBarButtonItem = nil
    navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "",
      style: UIBarButtonItemStyle.Plain,
      target: nil,
      action: nil)
  }
  
  override func viewWillAppear(animated: Bool) {
    TwitterAPI.fetchSearchResults() 
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
}

// MARK: UITextFieldDelegate
extension SearchTweetsViewController : UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}

// MARK: UITableViewDataSource
extension SearchTweetsViewController : UITableViewDataSource {
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  override func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    var cell = tableView.dequeueReusableCellWithIdentifier("Tweet Cell",
      forIndexPath: indexPath) as UITableViewCell
    
    cell.textLabel?.text = "\(indexPath.row) in section \(indexPath.section)"
    
    return cell
  }
}

// MARK: UITableViewDelegate
extension SearchTweetsViewController : UITableViewDelegate {
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
}

