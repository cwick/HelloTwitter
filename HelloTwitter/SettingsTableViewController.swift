//
//  Created by Carmen Wick on 10/6/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate {
  @IBOutlet weak var appSecretLabel: UILabel!
  @IBOutlet weak var appSecretValue: UITextField!
  
  @IBOutlet weak var appKeyLabel: UILabel!
  @IBOutlet weak var appKeyValue: UITextField!
  
  @IBAction func labelTapped(sender: UITapGestureRecognizer) {
    (sender.view?.superview?.subviews[1] as UIResponder).becomeFirstResponder()
  }
  
  @IBAction func doneClicked(sender: UIBarButtonItem) {
    App.defaults.setObject(appKeyValue.text, forKey: "app_key")
    App.defaults.setObject(appSecretValue.text, forKey: "app_secret")
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if textField == appKeyValue {
      appSecretValue.becomeFirstResponder()
    }
    else {
      textField.resignFirstResponder()
    }
    
    return true
  }
  
  override func viewDidLoad() {
    appKeyValue.text = App.defaults.stringForKey("app_key")
    appSecretValue.text = App.defaults.stringForKey("app_secret")
  }
}
