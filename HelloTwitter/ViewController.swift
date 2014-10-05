//
//  ViewController.swift
//  HelloTwitter
//
//  Created by Carmen Wick on 10/2/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    TwitterAPIAuthenticator.printBearerToken()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

