//
//  Tweet.swift
//  HelloTwitter
//
//  Created by Carmen Wick on 10/6/14.
//  Copyright (c) 2014 Carmen Wick. All rights reserved.
//

import Foundation

class TweetOld {
  private var data: NSDictionary
  let user: TwitterUserOld
  
  init(fromDictionary: NSDictionary) {
    data = fromDictionary
    user = TwitterUserOld(fromDictionary: data["user"] as NSDictionary)
  }
  
  var text: String {
    get {
      return data["text"] as String
    }
  }
}
