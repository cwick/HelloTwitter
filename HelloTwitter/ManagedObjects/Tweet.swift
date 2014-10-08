//
//  Tweet.swift
//  HelloTwitter
//
//  Created by Carmen Wick on 10/7/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import Foundation
import CoreData

class Tweet: NSManagedObject {
  @NSManaged var text: String
  @NSManaged var user: TwitterUser
  
  func initializeFromDictionary(data: NSDictionary) -> Tweet {
    user = (App.createManagedObject("TwitterUser") as TwitterUser).initializeFromDictionary(data["user"] as NSDictionary)
    text = data["text"] as String
    
    return self
  }
}
