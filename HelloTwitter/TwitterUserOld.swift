//
//  TwitterUser.swift
//  HelloTwitter
//
//  Created by Carmen Wick on 10/6/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import Foundation

class TwitterUserOld {
  private var data: NSDictionary
  
  init(fromDictionary: NSDictionary) {
    data = fromDictionary
  }
  
  var name: String {
    get {
      return data["name"] as String
    }
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