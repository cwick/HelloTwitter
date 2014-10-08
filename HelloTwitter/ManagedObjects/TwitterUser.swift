//
//  TwitterUser.swift
//  HelloTwitter
//
//  Created by Carmen Wick on 10/7/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import Foundation
import CoreData

class TwitterUser: NSManagedObject {
  @NSManaged var name: String
  @NSManaged var profileImageURL: String
  @NSManaged var tweets: NSSet
  
  func initializeFromDictionary(data: NSDictionary) -> TwitterUser {
    name = data["name"] as String
    profileImageURL = data["profile_image_url"] as String
    profileImageURL = profileImageURL.stringByReplacingOccurrencesOfString("_normal.jpeg",
        withString: "_bigger.jpeg",
        options: NSStringCompareOptions.BackwardsSearch,
        range: nil)
    
    return self
  }
}