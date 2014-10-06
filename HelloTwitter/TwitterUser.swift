//
//  TwitterUser.swift
//  HelloTwitter
//
//  Created by Carmen Wick on 10/6/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import Foundation

class TwitterUser {
  private var data: NSDictionary
  
  init(fromDictionary: NSDictionary) {
    data = fromDictionary
  }
  
  var profileImageURL: NSURL {
    get {
      var url = data["profile_image_url"] as String
      url = url.stringByReplacingOccurrencesOfString("_normal.jpeg",
        withString: "_bigger.jpeg",
        options: NSStringCompareOptions.BackwardsSearch,
        range: nil)
      
      return NSURL(string: url)
    }
  }
  
}