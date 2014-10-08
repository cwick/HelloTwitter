//
//  App.swift
//  HelloTwitter
//
//  Created by Carmen Wick on 10/7/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import Foundation
import CoreData

var _managedContext: NSManagedObjectContext!

class App {
  class var defaults: NSUserDefaults {
    get {
      return NSUserDefaults.standardUserDefaults()
    }
  }
  
  class func createManagedObject(entityName: String) -> NSManagedObject {
    return NSEntityDescription.insertNewObjectForEntityForName(entityName,
      inManagedObjectContext: managedContext) as NSManagedObject
  }
  
  class var managedContext: NSManagedObjectContext! {
    get {
      return _managedContext
    }
    set {
      _managedContext = newValue
    }
  }
}