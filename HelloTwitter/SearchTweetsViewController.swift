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
  private var dataSource = TweetsDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchField.delegate = self
    searchResults.dataSource = self.dataSource
    
    navigationItem.rightBarButtonItem = nil
    navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "",
      style: UIBarButtonItemStyle.Plain,
      target: nil,
      action: nil)
  }
  
  override func viewWillAppear(animated: Bool) {
    var api = TwitterAPI(
      key: "yr40AyjoUvDBlE2apn4dfsBqz",
      secret: "ZLelMvsTfhjOMoeDjy2qouo66HayjIVoXJWgMLUIQtCX7eY33Z")
    
    api.fetchSearchResults("technology") { results in
      self.dataSource.tweets = results["statuses"] as NSArray
      dispatch_after(1, dispatch_get_main_queue(), {
        self.tableView.reloadData()
      })
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
}

// MARK: UITextFieldDelegate
extension SearchTweetsViewController : UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
}

// MARK: UITableViewDelegate
extension SearchTweetsViewController : UITableViewDelegate {
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
}

