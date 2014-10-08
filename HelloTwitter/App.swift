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
var _managedObjectModel: NSManagedObjectModel!

class App {
  class var defaults: NSUserDefaults {
    get {
      return NSUserDefaults.standardUserDefaults()
    }
  }
  
  class func deleteAllObjectsForEntity(entityName: String) {
    var request = NSFetchRequest(entityName: entityName)
    request.includesPendingChanges = false
    request.includesPropertyValues = false
    var results = App.managedContext.executeFetchRequest(request, error: nil)
    for item in results! {
      managedContext.deleteObject(item as NSManagedObject)
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
  
  class var managedObjectModel: NSManagedObjectModel! {
    get {
      return _managedObjectModel
    }
    set {
      _managedObjectModel = newValue
    }
  }
}