//
//  Tweet.swift
//  HelloTwitter
//
//  Created by Carmen Wick on 10/6/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import Foundation

class Tweet {
  private var data: NSDictionary
  
  init(fromDictionary: NSDictionary) {
    data = fromDictionary
  }
  
  var text: String {
    get {
      return data["text"] as String
    }
  }
  
  var user: NSDictionary {
    get {
      return data["user"] as NSDictionary
    }
  }
  
  var profileImageURL: NSURL {
    get {
      var url = (data["user"] as NSDictionary)["profile_image_url"] as String
      url = url.stringByReplacingOccurrencesOfString("_normal.jpeg",
        withString: "_bigger.jpeg",
        options: NSStringCompareOptions.BackwardsSearch,
        range: nil)
      
      return NSURL(string: url)
    }
  }
}
