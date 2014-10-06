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
  let user: TwitterUser
  
  init(fromDictionary: NSDictionary) {
    data = fromDictionary
    user = TwitterUser(fromDictionary: data["user"] as NSDictionary)
  }
  
  var text: String {
    get {
      return data["text"] as String
    }
  }
}
